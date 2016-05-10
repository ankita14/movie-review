
require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module FrontView
end
# RailsAdmin::Config::Actions.register(self)

module RailsAdmin
	module Config
		module Actions
			class FrontView < RailsAdmin::Config::Actions::Base
				RailsAdmin::Config::Actions.register(self)
				# This ensures the action only shows up for Users
				 register_instance_option :visible? do
					authorized?
				end
				# register_instance_option :visible? do
				#   authorized? && bindings[:object].class == Movie
				# end
				# We want the action on members, not the Users collection
				register_instance_option :member do
					true
				end
				# register_instance_option :collection do
				#   true
				# end
				register_instance_option :link_icon do
					'icon-eye-open'
				end
				# You may or may not want pjax for your action
				register_instance_option :pjax? do
					false
				end
				register_instance_option :controller do
					Proc.new do		 
				  redirect_to "https://viva-movie-review.herokuapp.com/movie/#{@object.slug}"			
					end
				end
			end
		end
	end
end