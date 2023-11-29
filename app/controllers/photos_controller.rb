class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photos/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id })

    @the_photo = matching_photos.at(0)

    render({ :template => "photos/show" })
  end

  def create
    the_photo = Photo.new
    the_photo.creator_id = params.fetch("query_creator_id")
    the_photo.description = params.fetch("query_description")
    the_photo.image = params.fetch("query_image")
    the_photo.title = params.fetch("query_title")
    the_photo.album_id = params.fetch("query_album_id")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.creator_id = params.fetch("query_creator_id")
    the_photo.description = params.fetch("query_description")
    the_photo.image = params.fetch("query_image")
    the_photo.title = params.fetch("query_title")
    the_photo.album_id = params.fetch("query_album_id")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos/#{the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end

  def user_photos
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })
    
    render({ :template => "photos/user_photos" })

  end

  def new_photo
    render({ :template => "photos/new_photo" })
  end
end
