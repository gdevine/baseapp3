MANDRILL_API_KEY = "2YLXyYWCpAaqDeABk59MOw"

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mandrillapp.com",
  :port                 => 587,
  :enable_starttls_auto => true,
  :user_name            => "app36352493@heroku.com",
  :password             => MANDRILL_API_KEY,
  :authentication       => "login"
}


ActionMailer::Base.delivery_method = :test
ActionMailer::Base.default charset: "utf-8"
ActionMailer::Base.default_url_options = { :host => 'example.com', :protocol => 'https'}

