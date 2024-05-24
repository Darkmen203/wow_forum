class AuthsController < ApplicationController

    def create
      puts params.inspect
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
      puts params.inspect
      u = User.find_by(password: params[:password], email: params[:email])
      puts 'sss', u.inspect
      puts 'sssssssssssssss',u.id

      if not u.nil?
        session[:user_id] = u.id
        session[:avatar_url] = u.avatar_url
        session[:name] = u.name
        redirect_to root_path, notice: "You are logining"
      else redirect_to login_path_url
      end
    end

  end