class UserMailer < ApplicationMailer
  default from: "noreply@odinfacebook.com"

  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: "Welcome to Momo's odin facebook!")
  end
end
