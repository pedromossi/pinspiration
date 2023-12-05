class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })


    client = OpenAI::Client.new(access_token: "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")

    # response = client.chat(
    #   parameters: {
    #       model: "gpt-3.5-turbo", # Required.
    #       messages: [{ role: "user", content: "You are writing a description for a Pinterest post. You want to sound inspirational. Please write a paragraph on a photo about a country house."}], # Required.
    #       temperature: 0.7,
    #   })
    
    # @message = response.dig("choices", 0, "message", "content")
    

    messages = [
      { "type": "text", "text": "Create a Pinterest post description. Say why you like this image and why it is important to you. Use inspirational language. Create two sentences."},
      { "type": "image_url",
        "image_url": {
          "url": "https://www.livehome3d.com/assets/img/social/how-to-design-a-house.jpg",
        },
      }
    ]
    response = client.chat(
        parameters: {
            model: "gpt-4-vision-preview", # Required.
            messages: [{ role: "user", content: messages}], # Required.
            max_tokens: 300,
        })
    @message =  response.dig("choices", 0, "message", "content")

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
    the_photo.creator_id = current_user.id
    the_photo.description = params.fetch("query_description")
    the_photo.image = params.fetch("query_image")
    the_photo.title = params.fetch("query_title")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
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
    matching_photos = Photo.all.where({:creator_id => current_user.id})

    @list_of_photos = matching_photos.order({ :created_at => :desc })
    
    render({ :template => "photos/user_photos" })

  end

  def new_photo
    render({ :template => "photos/new_photo" })
  end
end
