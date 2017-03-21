class AdvertisementsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :show, :destroy]
  before_filter :correct_user, only: [:show, :destroy]

  def index
  end

  def free
  end

  def add_free_book
    if params[:title] == "" || params[:author] == "" || params[:subject] == "" || params[:pdfLink] == ""
      flash[:danger] = "One or more field missing"
      redirect_to '/advertisement/free'
    else
      response = post_solr_request(params[:title], params[:author], params[:subject], params[:pdfLink].split(/\r?\n/))
      puts response
      flash[:success] = "Your newly added book is now searchable!"
      redirect_to current_user
    end
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
      flash[:danger] = "Avert could not be created. Try again!"
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

    def post_solr_request(title, author, subject, links)
      uri = URI.parse("http://ec2-52-40-24-42.us-west-2.compute.amazonaws.com:8983/solr/TEXTBOOK_DB/update/json/docs?commit=true")
      data = "{
          \"title\":\"#{title}\",
          \"author\":\"#{author}\",
          \"subject\":\"#{subject}\",
          \"user\":\"#{current_user.email}\",
          \"password\":\"filtered\",
          \"pdfLink\": #{links}
        }"
      req = Net::HTTP::Post.new(uri, {'Content-Type' => 'application/json'})
      req.body = data

      http = Net::HTTP.new(uri.host, uri.port)
      response = http.request(req)
      response
    end
end
