class AdminMailer < ApplicationMailer

  default to: "gerarddevine@gmail.com"

  ## 1. Sending by Mandrill smtp  
  # def new_user_waiting_for_approval(user)
    # @user = user
    # mail(subject: "#{ Settings.site_title } Registration Request")
  # end
  
  ## or 2. Sending by Mandrill API  
  def new_user_waiting_for_approval(user)
    template_name = "admin-new-user"
    template_content = []
    message = {
      to: [{email:"gerarddevine@gmail.com"}],
      subject: "New User Alert: #{ user.fullname }",
      merge_vars: [
        {rcpt: "gerarddevine@gmail.com",
         vars: [
           {name: "new_user", content: user.fullname},
           {name: "new_user_email", content: user.email},
           {name: "site_title", content:Settings.site_title},
         ]
        }
      ]
    }
    
    mandrill_client.messages.send_template template_name, template_content, message
  end
  
end
