class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.date :age
      t.string :series
      t.string :diameter
      t.string :designer
      t.string :weight
      t.string :edge
      t.string :metal_content

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
