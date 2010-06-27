class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.belongs_to :item
      t.datetime :end_time
      t.string :top_bidder
      t.decimal :current_bid, :precision => 8, :scale => 2
      t.decimal :starting_amount, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end
