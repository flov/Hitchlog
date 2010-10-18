class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps
    end
    
    create_table "hitchhikes", :force => true do |t|
      t.string   "title"
      t.string   "from"
      t.string   "to"
      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.string   "photo_file_size"
      t.string   "photo_updated_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "people", :force => true do |t|
      t.string   "name"
      t.string   "occupation"
      t.string   "mission"
      t.string   "origin"
      t.integer  "hitchhike_id"
    end

    add_column :users, :avatar_file_name,    :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size,    :integer
    add_column :users, :avatar_updated_at,   :datetime
    
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
