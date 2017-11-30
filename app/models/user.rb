class User < ApplicationRecord
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise 	:database_authenticatable, :registerable,
    		:recoverable, :rememberable, :trackable, :validatable
    

    # ** used in views/admin/user/index.html.erb
    def to_s
    	"#{email} (#{admin? ? "Admin" : "User"})"
    end
end

