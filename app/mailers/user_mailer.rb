class UserMailer < ActionMailer::Base
  default from: "andrey.rizshnikov@phystech.edu"

  def welcome_email(requistion)
    @requistion = requistion
    mail(to: "ryznikov@mail.ru", subject: 'Welcome to My Awesome Site')
  end
end
