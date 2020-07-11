class Users::SessionsController < Devise::SessionsController
  def easy_login
    user = User.find(1)
    user.update(email: 'guest@example.com',name: 'ゲストユーザー') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_url
  end
end
