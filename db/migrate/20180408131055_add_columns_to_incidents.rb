class AddColumnsToIncidents < ActiveRecord::Migration[5.1]
  def change
    add_column :incidents, :plataform_kind, :string
    add_column :incidents, :captured_by, :string, null: true
  end
end
