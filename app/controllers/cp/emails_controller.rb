class Cp::EmailsController < Cp::AdminController
	load_and_authorize_resource :find_by => :slug
  def index
  	@emails = Email.all
  end

  def destroy
  	@email = Email.find(params[:id])
    @email.destroy
    redirect_to cp_emails_url, notice: "Адрес подписчика #{@email.email} удален."
  end
end
