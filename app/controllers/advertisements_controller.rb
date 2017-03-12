class AdvertisementsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :show, :destroy]
  before_filter :correct_user, only: [:show, :destroy]

  def index
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = current_user.advertisements.build(advertisements_params)
    if @advertisement.save
      flash[:success] = "Advert successfully created!"
      redirect_to @advertisement
    else
      flash[:error] = "Avert could not be created. Try again!"
      render 'new'
    end
  end

  def show
    @advertisement = current_user.advertisements.find(params[:id])
  end

  def edit
    @advertisement = current_user.advertisements.find(params[:id])
  end

  def update
    @advertisement = current_user.advertisements.find_by_id(params[:id])
    if @advertisement.update_attributes(advertisements_params)
      flash[:success] = "Advertisement Updated"
      redirect_to @advertisement
    else
      render 'edit'
    end
  end

  def destroy
    @advertisement.destroy
    return_back_or root_path
  end

  private
    def advertisements_params
      params.require(:advertisement).permit(:title, :price, :content, :preferred_contact, :location)
    end

    def correct_user
      @advertisement = current_user.advertisements.find_by_id(params[:id])
      redirect_to root_path if @advertisement.nil?
    end
end
