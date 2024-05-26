class AuthsController < ApplicationController

    def create
      if params[:password] == params[:password_confirmation]
        if !User.find_by(login: params[:login], email: params[:email]).present? and params[:login] != ''
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
          flash[:alert] = "Пользователь c таким именем уже существует или поле логин не заполнено"
          redirect_to register_path_url
          return
        end
      else
        flash[:alert] = "Пароли не совпадают"
        redirect_to register_path_url
        return
      end

    end

    def sign
      u = User.find_by(password: params[:password], email: params[:email])
      if u.present?
        session[:user_id] = u.id
        session[:avatar_url] = u.avatar_url
        session[:name] = u.name
        redirect_to root_path
      else 
        flash[:alert] = "Пароль или почта не верны"
        redirect_to login_path_url
      end
    end

    def change_password
      @user = User.find(session[:user_id])
      begin
        if @user.password==params[:current_password] and params[:new_password] == params[:new_password_confirmation]
          @user.update!(password: params[:new_password])
          flash[:notice] = "Пароль успешно изменен"
        else
          flash[:alert] = "Текущий пароль неверен, или новые пароли не совпадают"
        end          
      rescue => e
        Rails.logger.error("Error update password: #{e.message}")
        flash[:alert] = "Не удалось обновить пароль"
        return
      end
      redirect_to request.referer || root_path
      # redirect_to root_path
    end

    def update
      @user = User.find(session[:user_id])
      if user_params[:name] != '' and user_params[:name].present? and user_params[:name].length < 30
        if @user.update(user_params)
          flash[:notice] = "Имя успешно обновлено."
          session[:name] = user_params[:name]
          redirect_to request.referer
        else
          flash[:alert] = "Не удалось обновить имя."
          render :edit
        end
      else
        flash[:alert] = "Недопустимое имя."
        redirect_to request.referer
      end
    end

    def user_params
      params.require(:user).permit(:name)
    end

  end