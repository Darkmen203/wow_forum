class ProfilesController < ApplicationController
    
    def show
        redirect_to login_path_url unless current_user
        @user = User.find(session[:user_id]) unless !current_user
    end
  
    def my_questions
        redirect_to login_path_url unless current_user
    end
  
    def my_answers
        redirect_to login_path_url unless current_user
    end
    
    def settings
        redirect_to login_path_url unless current_user
    end
  end
  