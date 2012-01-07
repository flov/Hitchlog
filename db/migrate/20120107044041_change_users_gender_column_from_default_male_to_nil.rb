class ChangeUsersGenderColumnFromDefaultMaleToNil < ActiveRecord::Migration
  def up
    change_column_default :users, :gender, nil
  end

  def down
    change_column_default :users, :gender, 'male'
  end
end
