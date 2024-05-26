class PasswordResetsController < ApplicationController

  def new
    puts 'we are in new reset'
    puts params
  end

  def create
    puts 'we are in create reset'
    puts params
    u = User.find_by(email: params[:email_field])

    puts 'user', u.inspect
    if u.present?
      puts "naiden"
      u.send_password_reset
      redirect_to root_path
    end
    end

end
