class TinymceAssetsController < ApplicationController
  respond_to :json

  def create
    image    = Image.create params.permit(:file, :alt, :hint)
    geometry = Paperclip::Geometry.from_file image.file.path

    render json: {
      image: {
        url:    image.file.url,
        height: geometry.height.to_i,
        width:  geometry.width.to_i
      }
    }, layout: false, content_type: "text/html"
  end
end
