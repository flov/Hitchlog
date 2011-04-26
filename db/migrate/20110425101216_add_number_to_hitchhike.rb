class AddNumberToHitchhike < ActiveRecord::Migration
  def self.up
    add_column :hitchhikes, :number, :integer
    Trip.all.each do |trip|
      trip.hitchhikes.each_with_index do |hitchhike, i|
        hitchhike.update_attribute('number', i+1)
      end
    end
  end

  def self.down
    remove_column :hitchhikes, :number
  end
end
