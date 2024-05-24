class AuthsController < ApplicationController

    def create
      if params[:password] == params[:password_confirmation] and User.find_by_login(params[:login]).nil?
        u = User.create(
          provider: 'wowforum',
          password: params[:password],
          login: params[:login],
          email: params[:email],
          name: params[:login],
          avatar_url: '/skull-solid.svg',
          token: rand(1..1000))

        session[:user_id] = u.id
        session[:name] = u.name
        session[:avatar_url] = u.avatar_url
        redirect_to root_path
      else
        redirect_to register_path_url
      end

    end

    def sign
      u = User.find_by(password: params[:password], email: params[:email])
      if not u.nil?
        session[:user_id] = u.id
        session[:avatar_url] = u.avatar_url
        session[:name] = u.name
        redirect_to root_path, notice: "You are logining"
      else redirect_to login_path_url
      end
    end

    def change_password
      puts params.inspect
      @user = User.find(session[:user_id])
      puts '------------------------', @user.inspect
      if @user.password==params[:current_password] and params[:new_password] == params[:new_password_confirmation]
        @user.update(password: params[:new_password])
        puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
      end
      redirect_to root_path
    end

  end