class AddBeWelcomeUserToUser < ActiveRecord::Migration
  def change
    add_column :users, :be_welcome_user, :string
  end
end
