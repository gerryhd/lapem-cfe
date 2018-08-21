class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_application(user, application)
    @user = user
    @application = application
    mail(to: @user.applicant.email, subject: 'Nueva Solicitud')
  end

  def application_updated(user, application)
    @user = user
    @application = application
    mail(to: @user.applicant.email, subject: 'Actualización del estado de la solicitud')
  end

  def application_modified(user, application)
    @user = user
    @application = application
    mail(to: @user.applicant.email, subject: 'Solicitante ha modificado su solicitud')
  end

end
