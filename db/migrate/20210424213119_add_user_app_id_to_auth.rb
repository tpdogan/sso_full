class AddUserAppIdToAuth < ActiveRecord::Migration[6.1]
  def change
    add_column :auths, :user_app_id, :integer
  end
end
