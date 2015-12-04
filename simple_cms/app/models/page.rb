class Page < ActiveRecord::Base
  belongs_to :subject
  has_many :sections

  acts_as_list scope: :subject

  before_validation :add_default_permalink
  after_save :touch_subject
  after_destroy :delete_related_sections

  # has_and_belongs_to_many :admin_users
  has_and_belongs_to_many :editors, class_name: "AdminUser"

  validates :name, presence: true, 
  				   length: { maximum: 255 }
  validates :permalink, presence: true, 
  						length: { within: 3..255 }, 
  						uniqueness: true
  
  # use presence_of with length_of to siallow spaces
  
  # for unique values by subject use "scope: :subject_id"

  scope :visible, -> { where(visible: true) }
	scope :invisible, -> { where(visible: false) }
	scope :sorted, -> { order('pages.position ASC') }
	scope :newest_first, -> { order('pages.created_at DESC') }
	scope :search, -> (query) {  where(["pages.name LIKE ?", "%#{query}%"]) }

  private
    def add_default_permalink
      if permalink.blank?
          self.permalink = "#{id}-#{name.parameterize}" #convert name to url format
      end  
    end

    def touch_subject
      # touch is similar to:
      # subject.update_attribute(:updated_at, Time.now)
      subject.touch
    end
    def delete_related_sections
      self.sections.each do |section|
        # Or perhaps instead of destroy, you would
        # move them to another page.
        # section.destroy

      end
      
    end
end
