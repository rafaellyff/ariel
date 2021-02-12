class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.string :author
      t.string :source 
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
