class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.create(body: answer_params[:body], user_id: session[:user_id], question_id: request.referrer.split('/').last)
    # @answer = Answer.new(
    #   body: answer_params[:body],
    #   user_id: session[:user_id],
    #   question_id: params[:question_id]
    # )
    # puts '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n#FF0000'
    # puts request.referrer.split('/').last
    # puts @answer.user_id
    # puts @answer.body 
    if @answer.save
      redirect_to question_path(@answer.question_id), notice: "Ответ успешно создан."
    else
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end

