class Section < ActiveRecord::Base
 # belongs_to :page
  has_many :editors, class_name: 'AdminUser', through: :section_edits
  has_many :section_edits
end
