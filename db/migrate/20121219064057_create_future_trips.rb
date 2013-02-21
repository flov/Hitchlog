class CreateFutureTrips < ActiveRecord::Migration
  def change
    create_table :future_trips do |t|
      t.string :from
      t.string :to
      t.integer :user_id
      t.datetime :departure

      t.timestamps
    end
  end
end
