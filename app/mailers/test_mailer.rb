class TestMailer < ApplicationMailer
    def test_email
      mail(to: 'dima-pivovarov03@mail.ru', subject: 'Test Email', body: 'This is a test email.')
    end
end