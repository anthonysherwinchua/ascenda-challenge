# frozen_string_literal: true

class AddDeletedAtToHotel < ActiveRecord::Migration[7.1]
  def change
    add_column :hotels, :deleted_at, :datetime
    add_index :hotels, :deleted_at
  end
end
