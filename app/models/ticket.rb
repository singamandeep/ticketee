class Ticket < ApplicationRecord
	attr_accessor :tag_names

	def tag_names=(names)
		@tag_names = names
		names.split.each do |name|
			self.tags << Tag.find_or_initialize_by(name: name)
		end
	end

	# all associations below
	belongs_to :project
	belongs_to :author, class_name: "User"
	has_many :attachments, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank
	has_many :comments, dependent: :destroy
	belongs_to :state, optional: true
	has_and_belongs_to_many :tags, uniq: true

	# all validations below
	validates :name, :description, presence: true
	validates :description, length: {minimum: 10}

	# all callbacks below me 
	before_create :assign_default_state

	private

	def assign_default_state
		self.state ||= State.default
	end

end
