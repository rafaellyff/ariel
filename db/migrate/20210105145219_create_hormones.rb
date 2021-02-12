class CreateHormones < ActiveRecord::Migration[5.2]
  def change
    create_table :hormones do |t|
      t.references :molecule, foreign_key: true
      t.string :name
      t.integer :periodicity
      t.string :unit
      t.decimal :unit_per_dose
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
