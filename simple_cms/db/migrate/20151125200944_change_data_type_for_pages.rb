class ChangeDataTypeForPages < ActiveRecord::Migration
  def up
  	change_column :pages, :permalink, :string
  end

  def down
  	change_column :pages, :permalink, :integer
  end
end
