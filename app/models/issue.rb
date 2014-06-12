class Issue < ActiveRecord::Base
	belongs_to :truck

	validates :issue_body, presence: true
end
