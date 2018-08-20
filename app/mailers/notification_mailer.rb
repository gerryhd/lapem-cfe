class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_application(user, application)
    @user = user
    @application = application
    mail(to: @user.applicant.email, subject: 'Nueva Solicitud')
  end

end
