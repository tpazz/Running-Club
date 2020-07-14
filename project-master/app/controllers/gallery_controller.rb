class GalleryController < ApplicationController
  authorize_resource

  #Index action, photos gets listed in the order at which they were created
 def index
  @gallery_show = Gallery.order('created_at')
  @gallery = Gallery.new
 end

 #New action for creating a new photo
 def new
  @gallery = Gallery.new
 end

 def display
   @gallery = Gallery.find(params[:id])
   send_file @gallery.photo.path
 end

 #Create action ensures that submitted photo gets created if it meets the requirements
 def create
   @arry =[]
   photo_params[:photo].each do |img|
     image = Gallery.new(:photo => img)
     @arry += [image.save]
   end
   true_count = @arry.count(true)
   false_count = @arry.count(false)
   if true_count == 1
     flash[:gnotice] = "Successfully added: 1 image"
   elsif true_count > 1
     flash[:gnotice] = "Successfully added: " + true_count.to_s + " images"
   end
   if false_count == 1
     flash[:enotice] = "Error uploading: 1 image - files must not exceed 4MB (JPEG, PNG, GIF formats only)"
   elsif false_count > 1
     flash[:enotice] = "Error uploading: " + false_count.to_s + " images - files must not exceed 4MB (JPEG, PNG, GIF formats only)"
   end
   redirect_back fallback_location: 'index'
 end

 def destroy
  @photo = Gallery.find(params[:name])
    if @photo.destroy
      flash[:gnotice] = "Successfully deleted photo!"
    else
      flash[:enotice] = "Error deleting photo!"
    end
    redirect_back fallback_location: 'index'
  end

 private

 #Permitted parameters when creating a photo. This is used for security reasons.
 def photo_params
  params.require(:gallery).permit(:photo => [])
 end

end
