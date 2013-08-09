class StaticPagesController < ApplicationController
  def splash

  end

  def home
      if signed_in?
        @guest = current_user.guests.build
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
  end
end
