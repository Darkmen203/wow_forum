class ProfilesController < ApplicationController
    
    def show
        redirect_to login_path_url unless current_user
        @user = User.find(session[:user_id]) unless !current_user
    end
  
    def my_questions
        return redirect_to login_path_url unless current_user
        @question = Question.where(user_id: session[:user_id])
    end
  
    def my_answers
        redirect_to login_path_url unless current_user
    end
    
    def settings
        redirect_to login_path_url unless current_user
    end
  end
  