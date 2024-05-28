class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user["first_name"] = params["first_name"]
    @user["last_name"] = params["last_name"]
    @user["email"] = params["email"]
    # encrypt user's password before storing in database
    @user["password"] = BCrypt::Password.create(params["password"])
    @user.save
    redirect_to "/places"
  end

end

