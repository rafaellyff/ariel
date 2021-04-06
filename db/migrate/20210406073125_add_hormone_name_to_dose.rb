class AddHormoneNameToDose < ActiveRecord::Migration[5.2]
  def change
    add_column :doses, :hormone_name, :string
  end
end
