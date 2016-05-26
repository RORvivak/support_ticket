class ApplicationMailer < ActionMailer::Base
  default from: "staff@ticket.com"
  layout 'mailer'
end
