class UserMailer < ActionMailer::Base
  default from: "onlinesys3v@gmail.com"

  def welcome_email(requistion)
    @requistion = requistion
    mail(to: "ryznikov@mail.ru", subject: 'Welcome to My Awesome Site')
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Сброс пароля"
  end

end
