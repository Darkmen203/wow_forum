class PasswordResetsController < ApplicationController

  def new
    puts 'we are in new reset'

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

  def pass_form
    puts params
    @token = params[:token]
  end

  def change_pass_final
    puts params.inspect
    if params[:password] == params[:confirm_password]
      u = User.find_by(
      :reset_password_token => params[:token]
      )
      if u.present?
        u.update(:password => params[:password])
        puts "uspechno sozdano i izmeneno"
        redirect_to :login_path
      else
        puts "pustoi u"
      end

    end
    end

end
