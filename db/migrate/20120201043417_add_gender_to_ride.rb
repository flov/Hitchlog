class AddGenderToRide < ActiveRecord::Migration

  def self.up
    add_column :rides, :gender, :string
    # removing some rides which shouldn't be in the database
    Person.where("ride_id is null").each{ |person| person.destroy }

    Person.where("gender != ''").each do |person|
      ride = person.ride
      ride.gender = person.gender
      ride.save!
    end
    remove_column :people, :gender
    remove_column :people, :name
    remove_column :people, :age
  end

  def self.down
    remove_column :rides, :gender
    add_column :people, :gender, :string
    add_column :people, :name, :string
    add_column :people, :age,  :integer
  end
end
