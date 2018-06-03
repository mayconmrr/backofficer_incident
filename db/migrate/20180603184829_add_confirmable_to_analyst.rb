class AddConfirmableToAnalyst < ActiveRecord::Migration[5.1]
  def up
    add_column :analysts, :confirmation_token, :string
    add_column :analysts, :confirmed_at, :datetime
    add_column :analysts, :confirmation_sent_at, :datetime
    add_index :analysts, :confirmation_token, unique: true
    Analyst.all.update_all confirmed_at: DateTime.now
  end

  def down
    remove_columns :analysts, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
