class Auction::CustomerBidsController < ApplicationController
  before_filter :require_user
  before_filter :get_user, :only => [:new]
  before_filter :current_time

  def new
    @bid = @user.build_bid
    @bid.auction = @auction
    @bid.amount = @auction.current_bid
  end

  def create
    @bid = Bid.new(params[:bid])
    if @bid.save
      redirect_to auctions_view(@bid.auction_id)
    else
      @auction = Auction.find(@bid.auction_id)
      @user = current_user
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
    @auction = params[:auction_id]
  end

end
