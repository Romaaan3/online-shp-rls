class Cp::LeadsController < Cp::AdminController
  load_and_authorize_resource

  def index
    @cp_leads = Lead.paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    @cp_lead = Lead.find(params[:id])
    @cp_lead.destroy
    respond_to do |format|
      format.html { redirect_to cp_leads_url, notice: 'Заявка удалена.' }
      format.json { head :no_content }
    end
  end
end
