class Cp::PicturesController < Cp::AdminController
  load_and_authorize_resource
  def destroy
  	@picture = Picture.find(params[:id])
    @picture.destroy
  end
end
