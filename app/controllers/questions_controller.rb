class QuestionsController < ApplicationController

  def index
    @questions = Question.all.order(:created_at)
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @answer = Answer.find_by_question_id(:id)
  end


  def new
    @question = Question.new

  end

  def create

    @question = Question.create(title: question_params[:title],
                                body: question_params[:body],
                                user_id: session[:user_id]
    )

    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def create_answer
    puts params.inspect
    puts :id
    @answer = Answer.create(  body: params[:body],
                              user_id: session[:user_id],
                              question_id: :id)
  end


  private

  def question_params
    params.require(:question).permit(:title, :body)
  end


end
