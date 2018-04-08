class CreateIncidents < ActiveRecord::Migration[5.1]
  def change
    create_table :incidents do |t|
      t.references :analyst, optional: true
      t.references :backofficer, foreing_key: true
      t.integer :problem_kind
      t.integer :priority_level, default: 0
      t.string :problem_description
      t.string :pending_description
      t.string :solution_description
      t.string :reopened_description
      t.string :user_email
      t.string :user_cpf
      t.string :contract_id
      t.string :title
      t.integer :status, default: 0
      t.string :analysis_time
      t.datetime :analysis_started_at
      t.datetime :solved_at
      t.integer :entity

      t.timestamps
    end
  end
end
