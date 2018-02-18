class CreateBackofficers < ActiveRecord::Migration[5.1]
  def change
    create_table :backofficers do |t|
      t.string :name

      t.timestamps
    end
  end
end
