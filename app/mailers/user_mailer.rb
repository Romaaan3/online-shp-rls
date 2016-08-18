class UserMailer < ApplicationMailer
  default from: 'noreply@intellectit.by'

  def confirm_email(order, pass, user, rate)
    @order = order
    @pass = pass
    @user = user
    @token = user.confirmation_token
    @rate = rate
    mail(to: @order.email, subject: 'Данные для входа на сайт')
  end

  def successful_order(order, rate)
    @order = order
    @rate = rate
    mail(to: @order.email, subject: 'Спасибо за заказ')
  end

end
