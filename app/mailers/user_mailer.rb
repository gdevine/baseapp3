class UserMailer < ActionMailer::Base
  default from: 'notifications@baseapp2.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://baseapp2@uws.edu.au'
    mail(to: @user.email, subject: 'Welcome to Base App 2')
  end
  
  def new_user_waiting_for_approval(user)
    mail(to: 'g.devine@uws.edu.au', subject: 'Base App 2 Registration Request')
  end
  
end
