class CreateIncidents < ActiveRecord::Migration[5.1]
  def change
    create_table :incidents do |t|
      t.references :analyst, optional: true
      t.references :backofficer, foreing_key: true
      t.integer :problem_kind, default: 0
      t.integer :priority_level, default: 0
      t.string :description
      t.string :user_email
      t.string :title
      t.integer :status, default: 0
      t.string :solution_description
      t.string :analysis_time
      t.string :solution_time
      t.string :entity

      t.timestamps
    end
  end
end
