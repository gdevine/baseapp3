class ApplicationMailer < ActionMailer::Base  
  
  default from: "notifications@#{ Settings.site_appname }.com"
  
  def mandrill_client
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  end
end
