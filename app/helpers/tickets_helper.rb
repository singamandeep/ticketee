module TicketsHelper
	def state_transition_for(comment)
		if comment.previous_state != comment.state and comment.previous_state.present? and comment.state.present?
			content_tag(:div, class: "card-footer") do
				value = "<strong><i class='fa fa-cog' aria-hidden='true'></i> state changed</strong>" 
				value += " from #{render comment.previous_state}"
				value += " to #{render comment.state} "
				value.html_safe
			end
		end
	end

end
