class Ticket < ApplicationRecord
	belongs_to :project
	belongs_to :author, class_name: "User"
	has_many :attachments, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank


	validates :name, :description, presence: true
	validates :description, length: {minimum: 10}

end
