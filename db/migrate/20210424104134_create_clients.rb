class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :client_name
      t.string :client_id
      t.string :client_secret

      t.timestamps
    end
  end
end
