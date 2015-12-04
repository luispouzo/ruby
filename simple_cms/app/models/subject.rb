class Subject < ActiveRecord::Base

	# Could delete related pages automatically
	# wherever a subject is deleted:
	# has_many :pages, dependent: :destroy
	has_many :pages
	acts_as_list

	# Don't need to validate (in most cases):
	# ids, foreign keys, timestamps, booleans, counters
	validates :name, presence: true, 
					 length: { maximum: 255 }
	
	  # validates_presence_of vs. validates_length_of minumun: 1
	  # different error messages: "can't be blank" or "is too short"
	  # validates_length_of allows strings wth only spaces!

	scope :visible, -> { where(visible: true) }
	scope :invisible, -> { where(visible: false) }
	scope :sorted, -> { order('subjects.position ASC') }
	scope :newest_first, -> { order('subjects.created_at DESC') }
	scope :search, -> (query) {  where(["subjects.name LIKE ?", "%#{query}%"]) }
end
