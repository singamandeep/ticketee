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

	def toogle_watching_button(ticket)
		text = (ticket.watchers.include?(current_user)) ? "<i class='fa fa-eye-slash' aria-hidden='true'></i> Unwatch" : "<i class='fa fa-eye' aria-hidden='true'></i>
 Watch"
		# we used post method since we are going to create a new watcher
		link_to text.html_safe, watch_project_ticket_path(ticket.project, ticket), class: "btn btn-primary", method: :post
	end
end
