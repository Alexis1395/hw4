class PlacesController < ApplicationController
  before_action :current_user

  def current_user
    @current_user = User.find_by({ "id" => session["user_id"] })
  end 

  def index
    if @current_user
    @places = Place.all
    else 
      flash["notice"] = "You need to be logged in first."
      redirect_to "/login"
    end
  end

  def show
    if @current_user != nil
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
    else 
      flash["notice"] = "You need to be logged in first."
      redirect_to "/login"
    end 
  end

  def new
  end

  def create
    if @current_user != nil
    @place = Place.new
    @place["name"] = params["name"]
    # need to assign user to a newly created place
    @place.save
    else 
    flash["notice"] = "You need to be logged in first."
    end
    redirect_to "/places"
  end

end
