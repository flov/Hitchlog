class RemoveUnnecessaryAttributes < ActiveRecord::Migration
  def self.up
    remove_column :hitchhikes, :from
    remove_column :hitchhikes, :to
    remove_column :hitchhikes, :distance
    remove_column :hitchhikes, :date
    remove_column :hitchhikes, :user_id
        
    add_index(:users, :username)
  end

  def self.down
    add_column :hitchhikes, :from,     :string
    add_column :hitchhikes, :to,       :string
    add_column :hitchhikes, :distance, :integer
    add_column :hitchhikes, :user_id,  :integer
    add_column :hitchhikes, :date,     :datetime
    
    remove_index(:users, :username)
  end
end
