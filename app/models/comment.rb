class Comment < ApplicationRecord
  attr_accessor :tag_names

  # all associations below me
  belongs_to :ticket
  belongs_to :author, class_name: "User"
  belongs_to :state, optional: true
  belongs_to :previous_state, class_name: "State", optional: true

  validates :text, presence: true

  delegate :project, to: :ticket

  scope :persisted, lambda { where.not(id: nil) }

  # all callbacks below
  after_create :set_ticket_state
  before_create :set_previous_state
  after_create :associate_tags_with_tickets

private 

  def set_ticket_state
    if self.state.nil?
      self.previous_state = nil
    else
      ticket.state = state
      ticket.save!
    end
  end

  def set_previous_state
    self.previous_state = ticket.state
  end

  # setter method won't work as comments are not directly associated with tags in any way.
  def associate_tags_with_tickets
    if tag_names
      tag_names.split.each do |name|
        self.ticket.tags << Tag.find_or_create_by(name: name)
      end
    end
  end

end
