class ChangeVisibleDefaultValueForPages < ActiveRecord::Migration
  def up
  	change_column :pages, :visible, :string, default: false
  end

  def down
  	change_column :pages, :visible, :string, default: nil
  end
end
