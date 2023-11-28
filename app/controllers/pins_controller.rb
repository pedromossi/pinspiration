class PinsController < ApplicationController
  def index
    matching_pins = Pin.all

    @list_of_pins = matching_pins.order({ :created_at => :desc })

    render({ :template => "pins/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_pins = Pin.where({ :id => the_id })

    @the_pin = matching_pins.at(0)

    render({ :template => "pins/show" })
  end

  def create
    the_pin = Pin.new
    the_pin.photo_id = params.fetch("query_photo_id")
    the_pin.pinner_id = params.fetch("query_pinner_id")

    if the_pin.valid?
      the_pin.save
      redirect_to("/pins", { :notice => "Pin created successfully." })
    else
      redirect_to("/pins", { :alert => the_pin.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_pin = Pin.where({ :id => the_id }).at(0)

    the_pin.photo_id = params.fetch("query_photo_id")
    the_pin.pinner_id = params.fetch("query_pinner_id")

    if the_pin.valid?
      the_pin.save
      redirect_to("/pins/#{the_pin.id}", { :notice => "Pin updated successfully."} )
    else
      redirect_to("/pins/#{the_pin.id}", { :alert => the_pin.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_pin = Pin.where({ :id => the_id }).at(0)

    the_pin.destroy

    redirect_to("/pins", { :notice => "Pin deleted successfully."} )
  end
end
