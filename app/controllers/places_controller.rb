class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    if @user = nil 
      flash["notice"] = "You need to be logged in first."
    else 
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"] })
    end 
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user = nil 
      flash["notice"] = "You need to be logged in first."
    else 
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    end
    redirect_to "/places"
  end

end
