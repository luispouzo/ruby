class Section < ActiveRecord::Base

  belongs_to :page
  has_many :editors, class_name: 'AdminUser', through: :section_edits
  has_many :section_edits

  acts_as_list scope: :page
  after_save :touch_page

  CONTENT_TYPES = ['text','HTML']
  validates :name, presence: true, 
  				   length: { maximum: 255 }
  validates :content_type, inclusion: { in: CONTENT_TYPES, 
    message: "must be one of #{CONTENT_TYPES.join(', ')}" } 
  						   
  validates :content, presence: true

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }
  scope :sorted, -> { order('sections.position ASC') }
  scope :newest_first, -> { order('sections.created_at DESC') }
  scope :search, -> (query) {  where(["sections.name LIKE ?", "%#{query}%"]) }

private
  def touch_page
    page.touch
  end
end
