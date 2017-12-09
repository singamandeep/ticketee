class AttachmentsController < ApplicationController
	def show
		attachment = Attachment.find(params[:id])
		authorize attachment, :show?
		# ** send file methods sends file to the browser
		send_file attachment.file.path, disposition: :inline
	end
end
