class AddColumnImageLinkToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :image_link, :text
  end
end
