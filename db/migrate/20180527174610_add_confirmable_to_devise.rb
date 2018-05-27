class AddConfirmableToDevise < ActiveRecord::Migration[5.1]
  def up
    add_column :backofficers, :confirmation_token, :string
    add_column :backofficers, :confirmed_at, :datetime
    add_column :backofficers, :confirmation_sent_at, :datetime
    add_index :backofficers, :confirmation_token, unique: true
    Backofficer.all.update_all confirmed_at: DateTime.now
  end

  def down
    remove_columns :backofficers, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
