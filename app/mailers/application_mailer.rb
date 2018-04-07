class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@ticketeeapp.herokuapp.com'
  layout 'mailer'
end
