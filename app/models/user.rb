class User < ActiveRecord::Base
  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :linkedin]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }

	has_and_belongs_to_many :spaces, -> { uniq }
	has_many :blocks

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

    def soft_delete
      update_attribute(:deleted_at, Time.current)
    end

    def active_for_authentication?
      super && !deleted_at
    end

    def self.find_for_oauth(auth, signed_in_resource = nil)

      #Get the identity and user if they exist
      identity = Identity.find_for_oauth(auth)
      
      # If a signed_in_resource is provided it always overrides the existing user
      # to prevent the identity being locked with accidentally created accounts.
      # Note that this may leave zombie accounts (with no associated identity) which
      # can be cleaned up at a later date.
      user = signed_in_resource ? signed_in_resource : identity.user

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
            username: auth.extra.raw_info.name,
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

    def email_verified?
      self.email && self.email !~ TEMP_EMAIL_REGEX
    end

  	private

  		#def create_remember_token
  		#	self.remember_token = User.hash(User.new_remember_token)
  		#end
end
