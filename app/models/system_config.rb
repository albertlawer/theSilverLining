class SystemConfig < ActiveRecord::Base
	validates :name, presence: true
	validates :desc, presence: true
	validates :value, presence: true
end
