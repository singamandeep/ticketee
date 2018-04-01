class Ticket < ApplicationRecord
	# all associations below
	belongs_to :project
	belongs_to :author, class_name: "User"
	has_many :attachments, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank
	has_many :comments, dependent: :destroy
	belongs_to :state, optional: true

	# all validations below
	validates :name, :description, presence: true
	validates :description, length: {minimum: 10}

end
