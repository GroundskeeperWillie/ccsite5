class GuestsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :show, :put, :index]
  before_filter :correct_user,   only: [:destroy, :put] 
  before_filter :admin, only: [:create, :destroy]
  
    
  def index
    
    #@guests = Guest.paginate(page: params[:page], per_page: 25)
    @search = Guest.search(params[:q])
    @guests = @search.result
    @guests_all = Guest.paginate(page: params[:page])
    #@guests = @guests.select { |v| v.wedding_id == params[:wedding] } if !params[:guest_wedding].blank?
    #@guests = Guest.where("wedding LIKE ?", "%#{params[:search]}%")

    respond_to do |format|
      format.html
      format.csv { send_data @guests.to_csv }
      format.xls # { send_data @guests.to_csv(col_sep: "\t") }
    end
  end
  
  def create
    @guest = current_user.guests.build(params[:guest])
    if @guest.save
      flash[:success] = "Guest created!"
      redirect_to newguest_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @guest.destroy
    redirect_to newguest_path

  end
  
  def update
    @guest = Guest.find(params[:id])
    if @guest.update_attributes(params[:guest])
      flash[:success] = "Details updated"
      redirect_to home_path
    end
  end
    

  private

    def correct_user
      @guest = current_user.guests.find_by_id(params[:id])
      redirect_to root_url if @guest.nil?
    end
end