Mail.defaults do
    delivery_method :smtp, {
      address: 'smtp.mail.ru',
      port: 465,
      domain: 'mail.ru',
      user_name: ENV['MAILER_USERNAME'],
      password: ENV['MAILER_PASSWORD'],
      authentication: 'plain',
      enable_starttls_auto: true,
      ssl: true,
      tls: true
    }
  end