class AuthsController < ApplicationController
    def login
    #   @questions = Question.all.order(:created_at)
      redirect_to root_path, notice: "You are logining" unless !current_user
    end
  
    def register
    #   @question = Question.find(params[:id])
      redirect_to root_path, notice: "You are logining" unless !current_user

    end
  end