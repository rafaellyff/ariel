class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.date :scheduled_date
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
