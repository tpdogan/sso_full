class AddUserAppIdToToken < ActiveRecord::Migration[6.1]
  def change
    add_column :tokens, :user_app_id, :integer
  end
end
