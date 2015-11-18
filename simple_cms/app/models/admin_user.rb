class AdminUser < ActiveRecord::Base
	has_and_belongs_to_many :pages
	has_many :sections, through: :section_edits
	has_many :section_edits
end
