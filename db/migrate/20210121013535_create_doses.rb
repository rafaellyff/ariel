class CreateDoses < ActiveRecord::Migration[5.2]
  def change
    create_table :doses do |t|
      t.references :hormone, foreign_key: true
      t.date :expected_date
      t.decimal :amount
      t.date :realized_date
      t.decimal :realized_amount
      t.string :annotation
      t.string :status
      t.date :new_date
      t.string :apply_on

      t.timestamps
    end
  end
end
