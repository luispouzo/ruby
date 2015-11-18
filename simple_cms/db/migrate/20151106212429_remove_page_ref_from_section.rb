class RemovePageRefFromSection < ActiveRecord::Migration
  def change
    remove_belongs_to :sections, :page, index: true, foreign_key: true
  end
end
