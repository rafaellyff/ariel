class ChangeToDose < ActiveRecord::Migration[5.2]
  def change
    add_reference :doses, :user, foreign_key: true
    rename_column :doses, :expected_date, :scheduled_date
  end
end
