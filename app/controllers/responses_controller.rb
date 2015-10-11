class ResponsesController < ApplicationController

  def new
  	@response = Response.new
  end

  def create
  	@response = Response.new(response_params)
    @question = Question.find(params[:response][:question_id])
    if current_user.roles.find_by_name("Administrador").present?
      @response.approved = true
    end
    if @response.save
      flash[:notice] = "Tu respuesta ha sido enviada y en espera de ser moderada."
      if @question.user && @question.user.email
        UserMailer.new_response(@question).deliver
      end
      redirect_to :back
      # redirect_to admin_question_url(@question), :notice => "Pregunta enviada con exito"
    else
      render :action => 'new'
    end
  end

  private

  def set_response
    @response = Response.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def response_params
    params.require(:response).permit(:content, :user_id,:question_id)
  end
end