# frozen_string_literal: true

class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :url
      t.string :scrape_job_id
      t.integer :scrape_status

      t.timestamps
    end
  end
end
