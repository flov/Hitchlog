class AddStoryToHitchhike < ActiveRecord::Migration
  def self.up
    add_column :hitchhikes, :story, :text
  end

  def self.down
    remove_column :hitchhikes, :story
  end
end
