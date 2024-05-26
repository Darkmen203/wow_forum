class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILER_USERNAME']
  # default from: 'fordevprojectrussia@mail.ru'
  layout "mailer"
end
