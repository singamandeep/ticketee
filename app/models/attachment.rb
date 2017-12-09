class Attachment < ApplicationRecord
	# optional: true - for rails 5 i.e a ticket 
	belongs_to :ticket, optional: true

	mount_uploader :file, AttachmentUploader
end
