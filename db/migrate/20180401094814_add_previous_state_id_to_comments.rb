class AddPreviousStateIdToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :previous_state, index: true
    add_foreign_key :comments, :state, column: :previous_state_id
  end
end