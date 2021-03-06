module Rhinoart
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def google_oauth2
      # binding.pry
      @user = Rhinoart::User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        # sign_in_and_redirect @user, :event => :authentication
        sign_in @user, :event => :authentication
        redirect_to session[:redirect_to] || main_app.root_path

      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end

  end
end