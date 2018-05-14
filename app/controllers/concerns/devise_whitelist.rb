#module name need to match filename, rails parsing will recongize that.
module DeviseWhitelist 
    extend ActiveSupport::Concern

    included do 
        before_action :configure_permitted_parameters, if: :devise_controller?
    end

    def configure_permitted_parameters
        #:sign_up & :account_update provided in the Devise source code.
        #github:https://github.com/plataformatec/devise/blob/88724e10adaf9ffd1d8dbfbaadda2b9d40de756a/lib/devise/parameter_sanitizer.rb#L39
        devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
        devise_parameter_sanitizer.permit(:account_update, keys:[:name])
    end
end