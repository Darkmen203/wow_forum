
class UserMailer < ApplicationMailer
  default from: 'fordevprojectrussia@mail.ru'


  def password_reset(user)
    @user = user
    @reset_link ="http://localhost:3000/password_resets/" + @user.reset_password_token + '/edit'

    mail to: @user.email, subject: 'Password reset instructions'
  end
end
