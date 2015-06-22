class TransactionMailer < MandrillMailer::TemplateMailer
  default from: 'team@yourcompany.com', from_name: 'Your Company'
 
  def welcome(user)
    mandrill_mail template: 'welcome_email',
      subject: I18n.t('email.welcome.subject'),
      to: {email: user.email, name: user.fullname},
      vars: {
        'USER_IDENTIFIER' => user.email,
        'LIST_COMPANY' => 'Your Company'
      },
      important: true,
      inline_css: true,
      async: true
  end
end