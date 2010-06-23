class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.belongs_to :user
      t.belongs_to :auction

      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
