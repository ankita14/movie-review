
require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module ApprovedReviewList
end
# RailsAdmin::Config::Actions.register(self)

module RailsAdmin
	module Config
		module Actions
			class ApprovedReviewList < RailsAdmin::Config::Actions::Base
				RailsAdmin::Config::Actions.register(self)
				# This ensures the action only shows up for Users
				 register_instance_option :visible? do
					authorized?
				 end

				 # register_instance_option :visible do
				 # 	bindings[:object].class.name.downcase == 'movie'
		 		#  end
				# register_instance_option :visible? do
				#   authorized? && bindings[:object].class == Movie
				# end
				# We want the action on members, not the Users collection
				# register_instance_option :member do
				#   true
				# end
				register_instance_option :collection do
					true
				end
				register_instance_option :link_icon do
					'icon-filter'
				end
				# You may or may not want pjax for your action
				register_instance_option :pjax? do
					false
				end
				register_instance_option :controller do
					Proc.new do
						# @objects.bollywood_hungama
						# render action: @objects.bollywood_hungama
						# redirect_to back_or_index
					end
				end
			end
		end
	end
end