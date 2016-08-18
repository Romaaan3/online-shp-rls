class Fe::LeadsController < ApplicationController
  def create
  	@lead = Lead.create(lead_params)
  end

  private
  	def lead_params
  		params.require(:lead).permit(:name, :tel)
  	end
end
