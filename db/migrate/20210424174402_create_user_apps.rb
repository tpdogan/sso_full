class CreateUserApps < ActiveRecord::Migration[6.1]
  def change
    create_table :user_apps do |t|
      t.integer :user_id
      t.integer :client_id
      t.integer :auth_id
      t.integer :token_id

      t.timestamps
    end
  end
end
