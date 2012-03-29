class TweetsController < ApplicationController

  def index
    @tweets = Tweet.latest.page(1)
  end

  def geo
    @tweets = Tweet.latest_by_location(params[:geolat], params[:geolong]).page(1)
    render :index
  end

end