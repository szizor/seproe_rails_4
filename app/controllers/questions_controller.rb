class QuestionsController < ApplicationController
# before_filter :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @listings = Listing.order('name ASC').all
  	@questions = Question.order('created_at DESC').where(approved: true).all
    @question = Question.new
  end

  def new
    @listings = Listing.order('name ASC').all
  	@question = Question.new
  end

  def create
    @listings = Listing.order('name ASC').all
  	@question = Question.new(question_params)
    if @question.title.present? && @question.body.present?
      if @question.save
        UserMailer.new_question(@question).deliver
        redirect_to question_path(@question), :notice => "Tus preguntas e inquietudes son muy importantes para nosotros por lo que nos aseguraremos de responderte a la brevedad posible. Gracias por tu tiempo."
      end
    else
      render :action => 'new'
    end

  end

  def close
    @question = Question.friendly.find(params[:id])
    @question.update_attribute(:status, true)
    redirect_to question_path(@question), :notice => "Tus preguntas e inquietudes son muy importantes para nosotros por lo que nos aseguraremos de responderte a la brevedad posible. Gracias por tu tiempo."
  end

  def preguntas
    @listings = Listing.order('name ASC').all
    @user_id = current_user.id
    @user_questions = Question.where(:user_id => @user_id).all
  end

  def show
    @listings = Listing.order('name ASC').all
  	@response = Response.new
  	@question = Question.friendly.find(params[:id])
  end

  private

  def set_question
    @question = Question.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end