class Auction::CustomerBidsController < ApplicationController
  before_filter :require_user
  before_filter :get_user_and_auction, :only => [:new]

  def new
    @bid = @user.bids.build
    @bid.auction = @auction
    @bid.amount = @auction.current_bid    
  end

  def create
    @bid = Bid.new(params[:bid])
    if @bid.save
      redirect_to auctions_view_url(@bid.auction_id)
    else
      @auction = Auction.find(@bid.auction_id)
      @user = current_user
      @item = @auction.item
      render :action => :new
    end
  end

  def destroy
  end

  private

  def current_time
    @time = Time.now
  end

  def get_user_and_auction
    @user = current_user
    @auction = Auction.find(params[:auction_id])
    @item = @auction.item
  end

end
