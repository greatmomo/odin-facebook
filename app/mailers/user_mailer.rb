class UserMailer < ApplicationMailer
  default from: "noreply@odinfacebook.com"

  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:30000'
    mail(to: @user.email, subject: "Welcome to Momo's odin facebook!")
  end
end
