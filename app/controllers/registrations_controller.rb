class RegistrationsController < Devise::RegistrationsController

  def after_update_path_for(resource)
    user_path(resource)
  end

  #def create
  # Take into account acts_as_paranoid deleted users
	  #if (resource = resource_class.only_deleted.find_by_email(params[resource_name][:email]))
	   # resource.undelete!
	    # Copied from Warden::Strategies database_authenticatable:
	    #sign_in resource if resource.valid_password?(params[resource_name][:password])
	  #end
	  #super
	#end

  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end
end