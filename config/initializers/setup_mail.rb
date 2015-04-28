ActionMailer::Base.delivery_method = :sendmail

ActionMailer::Base.sendmail_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "hiedatamanager@gmail.com",
  :password             => "DM_Hawkesbury1",
  :authentication       => "plain",
  :enable_starttls_auto => true
}