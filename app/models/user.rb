class User < ActiveRecord::Base
  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :linkedin]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

	has_and_belongs_to_many :stories, -> { uniq }
	has_many :blocks

  	before_save { self.email = email.downcase }
    before_create :create_remember_token
  	validates :username, presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  	validates :password, length: { minimum: 6 }

    def self.find_for_oauth(auth, signed_in_resource = nil)

      #Get the identity and user if they exist
      identity = Identity.find_for_oauth(auth)
      user = identity.user ? identity.user : signed_in_resource

      # Create the user if needed
      if user.nil?

        # Get the existing user by email if the provider gives us a verified email
        # If the email has not been verified by the provider we will assign the
        # TEMP_EMAIL and get the user to verify it via UsersController.add_email
        email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
        email = auth.info.email if email_is_verified
        user = User.where(:email => email).first if email

        # Create the user if it's a new registration
        if user.nil?
          user = User.new(
            name: auth.extra.raw_info.name,
            #username: auth.info.nickname || auth.uid,
            email: email ? email : TEMP_EMAIL,
            password: Devise.friendly_token[0,20]
          )
          user.skip_confirmation!
          user.save!
        end
      end

      # Associate the identity with the user if needed
      if identity.user != user
        identity.user = user
        identity.save!
      end
      user
    end

  	def User.new_remember_token
  		SecureRandom.urlsafe_base64
  	end

  	def User.hash(token)
  		Digest::SHA1.hexdigest(token.to_s)
  	end

  	private

  		def create_remember_token
  			self.remember_token = User.hash(User.new_remember_token)
  		end
end
