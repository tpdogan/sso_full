class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.string :token_type, default: 'bearer'

      t.timestamps
    end
  end
end
