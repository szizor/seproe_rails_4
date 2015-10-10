# encoding: utf-8
class Admin::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  layout "admin"
  def index
    @questions = Question.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  def approve 
    @response = { approved: @question.approve }
    render({json: @response})
  end

  def show
    @response = Response.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @question.save
        format.html { redirect_to [:admin, @question], notice: 'Pregunta Creada Exitosamente' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to [:admin, @question], notice: 'Pregunta Editada Exitosamente' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:question).permit(:title, :body, :user_id)
    end
end