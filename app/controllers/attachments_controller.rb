class AttachmentsController < ApplicationController
	skip_after_action :verify_authorized, only: [:new]

	def show
		attachment = Attachment.find(params[:id])
		authorize attachment, :show?
		# ** send file methods sends file to the browser
		send_file attachment.file.path, disposition: :inline
	end

	def new
		@ticket = Ticket.new
		@ticket.attachments.build
		render layout: false
	end

end
