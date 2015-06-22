class UserMailer < ApplicationMailer

  def welcome_email(user)
    template_name = "welcome-new-user"
    template_content = []
    message = {
      to: [{email:user.email}],
      subject: "Welcome to #{ Settings.site_title }, #{ user.firstname.humanize } ",
      merge_vars: [
        {rcpt: user.email,
         vars: [
           {name: "user_firstname", content: user.fullname},
           {name: "user_email", content: user.email},
           {name: "site_title", content:Settings.site_title},
           {name: "site_url", content:Settings.site_url}
         ]
        }
      ]
    }
    
    mandrill_client.messages.send_template template_name, template_content, message
  end
  
end
