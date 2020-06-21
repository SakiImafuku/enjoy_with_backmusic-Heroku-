class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      flash[:success] = "ユーザー情報を更新しました"
      redirect_back_or root_url
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def email_update
    @user = current_user
    if @user.update(user_email_params)
      flash[:success] = "メールアドレスを変更しました"
      redirect_back_or root_url
    else
      render 'static_pages/settings'
    end
  end

  def edit_password
    @user = current_user
  end

  def password_update
    @user = current_user
    if @user.valid_password?(params[:user][:current_password])
      if @user.update(user_password_params)
        bypass_sign_in(@user)
        flash[:success] = "パスワードを変更しました"
        redirect_to root_path
      else
        render "edit_password"
      end
    else
      @user.errors.add(:current_password, 'が一致しません。')
      render "edit_password"
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name, :self_introduction])
  end

  def user_email_params
    params.require(:user).permit(:email)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
