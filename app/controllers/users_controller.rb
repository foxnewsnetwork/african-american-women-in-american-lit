class UsersController < ApplicationController
  def new
    @title = "Join us..."
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
      if @user.save
        flash[:success] = "Welcome!"
        redirect_to root_path
      else
        @title = "Sign up"
        @user.password = ''
        @user.password_confirmation = '' 
        render 'new'
      end
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
end
