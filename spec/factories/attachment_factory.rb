FactoryGirl.define do
	factory :attachment do
		# ** transient allows us to pass data which isn't an 
		# ** attribute in model so here we added a file_to_attach data 
		# ** which is not actually present in the attachment model
		transient do 
			file_to_attach "spec/fixtures/speed.txt"
		end

		file { File.open file_to_attach }
	end
end