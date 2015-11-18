class ChangeVisibleDefaultValueForSubject < ActiveRecord::Migration
  def up
  	change_column :subjects, :visible, :string, default: false
  end

  def down
  	change_column :subjects, :visible, :string, default: nil
  end
end
