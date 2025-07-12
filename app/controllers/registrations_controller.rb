class RegistrationsController < Devise::RegistrationsController 
   
    protected 
        def update_resource(resource, params) 
            resource.update_without_password(params)
        end

    def destroy
        # Delete all rooms associated with the user first
        current_user.rooms.destroy_all
        
        # Then delete the user account
        super
    end
end