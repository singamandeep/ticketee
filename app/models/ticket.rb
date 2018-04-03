class Ticket < ApplicationRecord
	include SearchCop

	attr_accessor :tag_names

	def tag_names=(names)
		@tag_names = names
		names.split.each do |name|
			# this creates all associations by itself
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

	# searching

	search_scope :search do
	  attributes tags: "tags.name"
	  attributes state: "state.name"
	end

	def self.search_query(query)
  		if query.present?
			search(query)
		else
			scope
		end
  	end
end
