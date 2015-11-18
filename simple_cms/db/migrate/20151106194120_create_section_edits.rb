class CreateSectionEdits < ActiveRecord::Migration
  def change
    create_table :section_edits do |t|
    	t.references :admin_user, index: true, foreign_key: true
    	t.references :section, index: true, foreign_key: true
    	t.string :summary
    	# t.belongs_to :admin_user, index: true, foreign_key: true
			# t.belongs_to :section, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
