class RenameGenderDataOfPerson < ActiveRecord::Migration
  def up
    Person.find_all_by_gender('both').each do |person|
      person.gender = 'mixed'
      person.save!
    end
  end

  def down
    Person.find_all_by_gender('mixed').each do |person|
      person.gender = 'both'
      person.save!
    end
  end
end
