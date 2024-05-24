class SessionsController < ApplicationController
    def github_auth
     client_id = ENV['GITHUB_ID']
     redirect_uri = 'http://localhost:3000/auth/github/callback'
     scope = 'user,repo'
     github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scope}"
     redirect_to github_url, allow_other_host: true
    end
   
    def github_callback
      client_id = ENV['GITHUB_ID']
      client_secret = ENV['GITHUB_SECRET']
      code = params[:code]
    
      response = HTTParty.post('https://github.com/login/oauth/access_token', {
                                  body: {
                                    client_id: client_id,
                                    client_secret: client_secret,
                                    code: code
                                  },
                                  mode: 'no-cors',
        headers: { 'Accept' => 'application/json' }
                                })
    
      access_token = response.parsed_response['access_token']
    
      # Используйте access_token для получения информации о пользователе
      user_info = HTTParty.get('https://api.github.com/user', {
                                  headers: {
                                    'Authorization' => "token #{access_token}",
                                    'User-Agent' => 'RailsApp'
                                  },
                                })
      user_data = user_info.parsed_response
      puts user_data


       # Получение email адресов
      email_info = HTTParty.get('https://api.github.com/user/emails', {
        headers: {
          'Authorization' => "token #{access_token}",
          'User-Agent' => 'RailsApp'
        }
      })

      if email_info.parsed_response.is_a?(Hash) && email_info.parsed_response['message']
        redirect_to root_path, alert: 'Ошибка при получении email адреса пользователя с GitHub.'
        return
      end

      emails = email_info.parsed_response
      primary_email = emails.find { |email| email['primary'] && email['verified'] }&.dig('email')
      primary_email ||= emails.find { |email| email['verified'] }&.dig('email')

      if primary_email.nil?
        redirect_to root_path, alert: 'Не удалось получить email адрес пользователя с GitHub.'
        return
      end

      user = User.find_or_create_by(id: user_data['id'], provider: 'github') do |u|
        u.login = user_data['login']
        u.email = primary_email
        u.name = user_data['name'] ? user_data['name'] : user_data['login']
        u.avatar_url = user_data['avatar_url']
        u.token = access_token
      end
      puts 'user.login'
      puts user.login
      puts 'user.name'
      puts user.name
      puts 'user.email'
      puts user.email
      puts user.token
      puts user.provider
      puts user.id
      session[:user_id] = user.id
    
      redirect_to root_path, notice: 'Signed in!'
    end
   
    def destroy
     session[:user_id] = nil
     redirect_to root_path, notice: 'Signed out!'
    end
   end
   