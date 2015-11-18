class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.integer :permalink
      t.integer :position
      t.boolean :visible
      t.references :subject, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :pages, :permalink
  end
end
