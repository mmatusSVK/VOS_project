class ContactMailer < ApplicationMailer
  def send_contact(data)
    mail(to: 'matus.salat@gmail.com', subject: 'Somebody has contacted you.', from: data.email, body: data.body)
  end
end
