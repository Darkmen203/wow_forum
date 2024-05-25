class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    redirect_to login_path_url unless current_user
    if(answer_params[:body] != "" and answer_params[:body].present?)
      @answer = Answer.create(body: answer_params[:body], user_id: session[:user_id], question_id: request.referrer.split('/').last)
      if @answer.save
        redirect_to question_path(@answer.question_id), notice: "Ответ успешно создан."
      else
        flash[:alert] = "Ошибка! ответ не создан"
        redirect_to request.referer
      end
    else
      flash[:alert] = "Ошибка! Вам нужно написать сообщение"
      redirect_to request.referer
    end 
  end

  def destroy
    @answer = Answer.find_by(id: params[:id], user_id: current_user.id)
    if @answer
      @answer.destroy
      flash[:notice] = "Ответ успешно удалён."
    else
      flash[:alert] = "Ответ не найден или у вас нет прав на его удаление."
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end

