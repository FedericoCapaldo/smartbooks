class UsersController < ApplicationController
  # before filter applies before any controller action
  before_filter :signed_in_user, only: [:edit, :update, :show]
  before_filter :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "New account successfully created!"
      redirect_to @user #redirect to show page
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end


  def destroy
    User.find(params[:id]).destroy
    sign_out
    flash[:success] = "User destroyed"
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :school, :password, :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      redirect_to(root_path) unless current_user?(@user)
    end
end
