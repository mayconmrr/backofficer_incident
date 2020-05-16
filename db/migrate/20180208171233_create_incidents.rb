# frozen_string_literal: true

class CreateIncidents < ActiveRecord::Migration[5.1]
  def change
    create_table :incidents do |t|
      t.references :analyst, optional: true
      t.references :backofficer, foreing_key: true
      t.string :problem_kind, default: 'bug_system'
      t.string :priority_level, default: 'low'
      t.string :problem_description
      t.string :pending_description
      t.string :solution_description
      t.string :reopened_description
      t.string :user_email
      t.string :user_cpf
      t.string :contract_id
      t.string :title
      t.string :status, default: 'open'
      t.string :analysis_time
      t.datetime :analysis_started_at
      t.datetime :solved_at
      t.string :entity

      t.timestamps
    end
  end
end
