class CreateTrips < ActiveRecord::Migration
  def self.up
    create_table :trips do |t|
      t.integer :distance
      t.datetime :date
      t.integer :duration
      t.string :from
      t.string :to

      t.timestamps
    end
  end

  def self.down
    drop_table :trips
  end
end
