# frozen_string_literal: true

class AddColumnsToIncidents < ActiveRecord::Migration[5.1]
  def change
    add_column :incidents, :plataform_kind, :string
    add_column :incidents, :captured_by, :string, null: true
    add_column :incidents, :pending_reason, :string
    add_column :incidents, :reopening_description, :string
    add_column :incidents, :incident_reopened, :boolean, default: false
    add_column :incidents, :reopened_by, :string, null: true
    add_column :incidents, :user_name, :string, null: true
  end
end
