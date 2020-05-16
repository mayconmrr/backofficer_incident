# frozen_string_literal: true

class RemoveUserCpfColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :incidents, :user_cpf, :string
  end
end
