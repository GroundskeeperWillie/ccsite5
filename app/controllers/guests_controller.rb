class GuestsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :show, :put]
  before_filter :correct_user,   only: [:destroy, :put] 
    
  def index
    @guests = Guest.paginate(page: params[:page])
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