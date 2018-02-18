class CreateAnalysts < ActiveRecord::Migration[5.1]
  def change
    create_table :analysts do |t|
      t.string :name

      t.timestamps
    end
  end
end
