class CreateBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :boxes do |t|
      t.decimal :amount
      t.decimal :remaining_amount
      t.date :date_start
      t.date :expiration_date
      t.references :hormone, foreign_key: true

      t.timestamps
    end
  end
end
