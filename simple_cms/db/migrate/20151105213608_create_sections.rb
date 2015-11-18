class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :position
      t.boolean :visible, default: false
      t.string :content_type
      t.text :content
      t.references :page, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
