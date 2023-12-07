class PinsController < ApplicationController
  def index
    the_user_id = params.fetch("user_id")

    @the_user = User.all.where({:id => the_user_id}).at(0)
    
    matching_photos = @the_user.pinned_photos

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "pins/index" })
  end

  def create
    the_pin = Pin.new
    the_pin.photo_id = params.fetch("photo_id")
    the_pin.pinner_id = current_user.id

    if the_pin.valid?
      the_pin.save
      redirect_to("/pins/#{current_user.id}", { :notice => "Pin created successfully." })
    else
      redirect_to("/pins/#{current_user.id}", { :alert => the_pin.errors.full_messages.to_sentence })
    end
  end

  def destroy
    user_id = current_user.id
    photo_id = params.fetch("photo_id")
    the_pin = Pin.where({ :pinner_id => user_id , :photo_id => photo_id }).at(0)

    the_pin.destroy

    redirect_to("/pins/#{current_user.id}", { :notice => "Pin deleted successfully."} )
  end
end
