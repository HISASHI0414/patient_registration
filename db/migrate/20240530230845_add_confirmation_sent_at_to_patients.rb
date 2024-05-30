class AddConfirmationSentAtToPatients < ActiveRecord::Migration[7.1]
  def change
    add_column :patients, :confirmation_token, :string
    add_column :patients, :confirmation_token_sent_at, :datetime
    add_column :patients, :confirmed_at, :datetime
    add_index :patients, :confirmation_token, unique: true
  end
end
