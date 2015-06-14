class ContactMailer < ApplicationMailer

  def send_contact(data)
    mail(to: 'matus.salat@gmail.com', subject: 'Somebody has contacted you from: ' + data.email, body: data.body)
  end

  def send_reply(data)
    @data = data
    mail(to: data.email, subject: 'Potvrdenie odoslania')
  end
end
