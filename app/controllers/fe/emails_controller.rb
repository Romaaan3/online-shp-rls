class Fe::EmailsController < ApplicationController
	def create
    @email = Email.new(email_params)

    if @email.save
    	BasicNotifyMailer.new_address_for_notify(@email).deliver_later
      redirect_to fe_root_path, notice: "Адрес #{@email.email} добавлен в список оповещения о запуске."
    else
      redirect_to fe_root_path, notice: 'Что-то пошло не так, попробуйте еще раз.'
    end
	end

	private
		def email_params
			params.require(:email).permit(:email)
		end
end
