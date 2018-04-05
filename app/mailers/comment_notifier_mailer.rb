class CommentNotifierMailer < ApplicationMailer
	# Although created should be a class function, But here we go for method_missing - The Great 'Ruby'
	def created(comment, user)
		@comment = comment
		@user = user

		@ticket = comment.ticket
		@project = @ticket.project

		subject = "[ticketee] #{@project.name} - #{@ticket.name}"
		mail(to: user.email, subject: subject)
	end
end
