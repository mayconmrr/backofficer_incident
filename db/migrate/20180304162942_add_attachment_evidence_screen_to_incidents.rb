# frozen_string_literal: true

class AddAttachmentEvidenceScreenToIncidents < ActiveRecord::Migration[5.1]
  def self.up
    change_table :incidents do |t|
      t.attachment :evidence_screen
    end
  end

  def self.down
    remove_attachment :incidents, :evidence_screen
  end
end
