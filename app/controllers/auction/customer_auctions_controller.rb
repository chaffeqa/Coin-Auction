class Auction::CustomerAuctionsController < ApplicationController
  before_filter  :current_time

  def categories
    @auctions = Auction.category_group
  end

  def list
    if params[:list_by_cheapest].blank?
        @auctions = Auction.list_by_time_left
    elsif params[:list_by_most_expensive].blank?
        @auctions = Auction.list_by_time_left
    elsif params[:list_by_name].blank?
        @auctions = Auction.list_by_time_left
    else
      @auctions = Auction.list_by_time_left
    end
    
  end

  def view
    @auction = Auction.find(params[:id])
  end

  private

  def current_time
    @time = Time.now
  end

end
