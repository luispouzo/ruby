class AdminUser < ActiveRecord::Base
	# To configure a different table name:
	# self.table_name = "admin_users"

	has_secure_password

	has_and_belongs_to_many :pages
	has_many :sections, through: :section_edits
	has_many :section_edits

	scope :sorted, -> { order("admin_users.last_name ASC, admin_users.first_name ASC") }

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	FORBIDDEN_USERNAMES = ['littlebopeep','humptydumpty','marymary']

	validates :first_name, presence: true, 
						   length: { maximum: 25 }
	validates :last_name, presence: true, 
						  length: { maximum: 50 }
	validates :username, presence: true, 
						 length: { within: 8..25 }, 
						 uniqueness: true
	validates :email, presence: true, 
					  length: { maximum: 100 }, 
					  format: { with: EMAIL_REGEX }, 
					  confirmation: true
	validate :username_is_allowed
	# validate :no_new_users_on_saturday, on: :create

	# this function it is the same that uses exclude valdations
	def username_is_allowed
		if FORBIDDEN_USERNAMES.include?(username)
			errors.add(:username,'has been restricted from use.')
		end
	end
	
	def no_new_users_on_saturday
		if Time.now.wday == 6
			errors[:base] << 'No new users on Saturday.'
		end		
	end

	def name
		"#{first_name} #{last_name}"
	end
# # -----
# 	def self.authenticate_safely(user_name, password)
#     where("user_name = ? AND password = ?", user_name, password).first
#   end

#   def self.authenticate_safely_simply(user_name, password)
#     where(user_name: user_name, password: password).first
#   end
end
