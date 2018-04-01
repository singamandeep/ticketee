class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: "User"
  belongs_to :state, optional: true

  validates :text, presence: true

  delegate :project, to: :ticket

  scope :persisted, lambda { where.not(id: nil) }

  # all callbacks below
  after_create :set_ticket_state

  private 

  def set_ticket_state
  	ticket.state = state
  	ticket.save!
  end

end
