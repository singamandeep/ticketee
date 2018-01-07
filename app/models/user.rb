class User < ApplicationRecord
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise 	:database_authenticatable, :registerable,
    		:recoverable, :rememberable, :trackable, :validatable
    
    # ** define all associations here
    has_many :roles


    # ** all used in Archive
    scope :excluding_archived, lambda { where(archived_at: nil) }

    def archive 
        self.update(archived_at: Time.now)
    end

    def active_for_authentication?
        super && archived_at.nil?
    end

    def inactive_message
        archived_at.nil? ? super : :archived
    end

    # ** used in views/admin/user/index.html.erb
    def to_s
    	"#{email} (#{admin? ? "Admin" : "User"})"
    end

    # ** used in select _form partial /admin/user
    def role_on(project)
        # ** first find if the a role is assigned for the current project_id
        # ** if role is defined then find the name based on user
        # ** we have used try as if find_by returns nil then there is no
        # ** project_id hence no need to get further in finding the role name
        roles.find_by(project_id: project).try(:name)
    end

    def generate_api_key
        self.update_column(:api_key, SecureRandom.hex(16))
    end
end

