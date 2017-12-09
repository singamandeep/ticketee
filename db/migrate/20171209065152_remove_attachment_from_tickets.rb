class RemoveAttachmentFromTickets < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :attachment, :string
  end
end
