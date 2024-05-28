class SessionsController < ApplicationController
  def new
  end

  def create
    #authenticate the user 
    #1. try to find the user by their unique indentifier 
    @user = User.find_by({"email" => params["email"]})
    #2. if the user exists -> check if they know their password 
    if @user != nil 
      #3a if they know their password -> log in successful
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["first_name"]}!"
        redirect_to "/places"
      else
      #3b. if user doesn't know their password -> login fails 
      flash["notice"] = "Please check your login details."
      redirect_to "/login"
      end
    else 
    #3. if the user does not exist -> login fails
    flash["notice"] = "Please check your login details."
    redirect_to "/login"
    end 
  end

  def destroy
    #logout the user 
    flash["notice"] = "Logged out successfully."
    session["user_id"] = nil 
    redirect_to "/login"
  end
end
  