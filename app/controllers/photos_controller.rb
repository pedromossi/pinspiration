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

    @the_comments = @the_photo.comments

    render({ :template => "photos/show" })
  end

  def create

    photo = params.fetch("query_image")

    client = OpenAI::Client.new(access_token: "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")

    messages = [
      { "type": "text", "text": "Create a Pinterest post description. Say why you like this image and why it is important to you. Use inspirational language. Create two sentences. Do not add quotes."},
      { "type": "image_url",
        "image_url": {
          "url": photo,
        },
      }
    ]
    response = client.chat(
        parameters: {
            model: "gpt-4-vision-preview", # Required.
            messages: [{ role: "user", content: messages}], # Required.
            max_tokens: 300,
        })
    
    description = response.dig("choices", 0, "message", "content")


    the_photo = Photo.new
    the_photo.creator_id = current_user.id
    the_photo.description = description
    the_photo.image = photo
    the_photo.title = params.fetch("query_title")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos/#{the_photo.id}", { :notice => "Photo created successfully." })
    else
      redirect_to("/new_photo", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    # the_photo.creator_id = params.fetch("query_creator_id")
    the_photo.description = params.fetch("query_description")
    the_photo.image = params.fetch("query_image")
    the_photo.title = params.fetch("query_title")

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
    the_user_id = params.fetch("user_id")

    @the_user = User.all.where(:id => the_user_id).at(0)

    matching_photos = Photo.all.where({:creator_id => the_user_id})

    @list_of_photos = matching_photos.order({ :created_at => :desc })
    
    render({ :template => "photos/user_photos" })

  end

  def new_photo
    render({ :template => "photos/new_photo" })
  end
end
