class Admin::AuctionsController < ApplicationController
  before_filter :require_user
  
  # GET /auctions
  # GET /auctions.xml
  def index
    @auctions = Auction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @auctions }
    end
  end

  # GET /auctions/1
  # GET /auctions/1.xml
  def show
    @auction = Auction.find(params[:id])
    @item = @auction.item
    @bids = @auction.bids.order("created_at desc")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @auction }
    end
  end

  # GET /auctions/new
  # GET /auctions/new.xml
  def new
    @auction = Auction.new
    @auction.item_id = params[:item_id] if params[:item_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @auction }
    end
  end

  # GET /auctions/1/edit
  def edit
    @auction = Auction.find(params[:id])
  end

  # POST /auctions
  # POST /auctions.xml
  def create
    @auction = Auction.new(params[:auction])

    respond_to do |format|
      if @auction.save
        format.html { redirect_to(admin_auction_path(@auction), :notice => 'Auction was successfully created.') }
        format.xml  { render :xml => @auction, :status => :created, :location => @auction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @auction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /auctions/1
  # PUT /auctions/1.xml
  def update
    @auction = Auction.find(params[:id])

    respond_to do |format|
      if @auction.update_attributes(params[:auction])
        format.html { redirect_to(admin_auction_path(@auction), :notice => 'Auction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @auction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.xml
  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroy

    respond_to do |format|
      format.html { redirect_to(admin_auctions_url) }
      format.xml  { head :ok }
    end
  end

  # DELETE /admin/auctions/destroy_bid/1
  def destroy_bid
    @bid = Bid.find(params[:bid_id])
    @bid.destroy

    respond_to do |format|
      format.html { redirect_to(:back || admin_auction_url(params[:auction_id])) }
      format.xml  { head :ok }
    end
  end
end
