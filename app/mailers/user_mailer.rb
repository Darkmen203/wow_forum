
class UserMailer < ApplicationMailer
  default from: 'fordevprojectrussia@mail.ru'


  def password_reset(user)
    @user = user
    @reset_link ="http://localhost:3000/password_resets?token=" + @user.reset_password_token

    mail to: @user.email, subject: 'Password reset instructions'
  end
end
