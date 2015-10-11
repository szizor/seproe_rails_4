# encoding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "bacosta@guadalajara.gob.mx",
          :bcc => ["szizor@hotmail.com"]

  def user_registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Bienvenido al programa de Adopta un Espacio")
  end

  def adopter_registration_confirmation(adopter)
    @adopter = adopter
    mail(:to => adopter.email, :subject => "Gracias por tu interés en adoptar un espacio público.")
  end

  def new_question(question)
    @question = question
    mail(:to => "bacosta@guadalajara.gob.mx", :subject => "Tienes una pregunta nueva.")
  end

  def new_response(question)
    @question = question
    mail(:to => question.user.email, :subject => "Respondieron tu pregunta.")
  end
end