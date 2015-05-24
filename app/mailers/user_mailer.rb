class UserMailer < ActionMailer::Base
  default from: 'notifications@baseapp3.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://baseapp3@uws.edu.au'
    mail(to: @user.email, subject: 'Welcome to #{ Settings.site_title }')
  end
  
  def new_user_waiting_for_approval(user)
    mail(to: 'g.devine@uws.edu.au', subject: '#{ Settings.site_title } Registration Request')
  end
  
end
