class BasicNotifyMailer < ApplicationMailer
  def new_address_for_notify(email)
    @email = email
    mail(to: "support@intellectit.by", subject: 'Новый адрес для оповещения о запуске')
  end
end
