require Rails.root.join('lib', 'rails_admin', 'bollywood_hungama.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::BollywoodHungama)
require Rails.root.join('lib', 'rails_admin', 'latest_movie.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::LatestMovie)
require Rails.root.join('lib', 'rails_admin', 'upcoming_movie.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::UpcomingMovie)

RailsAdmin.config do |config|

	config.default_items_per_page = 10

	### Popular gems integration
	# config.excluded_models << "Rate"
	config.included_models = ["Banner", "Movie", "Review", "Genre", "User", "MovieType"]

	# config.actions do
	#   searchable false
	# end

	## == Devise ==
	config.authenticate_with do
		warden.authenticate! scope: :admin
	end
	config.current_user_method(&:current_admin)
	# config.authenticate_with do
	#   warden.authenticate! scope: :user
	# end
	# config.current_user_method(&:current_user)

	## == Cancan ==
	# config.authorize_with :cancan

	## == Pundit ==
	# config.authorize_with :pundit

	## == PaperTrail ==
	# config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

	### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

	# def title
	#   title
	# end
	config.model Movie do
		navigation_icon 'icon-film'
		edit do
			# For RailsAdmin >= 0.5.0
			field :title
			field :description, :ck_editor
			field :movie_reviews, :ck_editor
			field :genres
			field :movie_type
			field :director
			field :producer
			field :music_director		
			field :star_cast
			field :release_date
			field :movie_length		
			field :youtube_url
			field :image
	    field :admin_id, :hidden do
	      default_value do
	        bindings[:view]._current_user.id
	      end
	    end
	    # field :critics_ratings, :has_and_belongs_to_many_association do
        
     #  end
	    # field :critics_rating
		end

		list do
			
	    field :title do
        filterable false
        searchable true
      end			

	    field :genres do
        filterable false
        searchable false
      end			
	    field :director do
        filterable false
        searchable false
      end			
	    field :rating do
        filterable false
        searchable false
      end			

	  end
	end

	config.model Review do
		navigation_icon 'icon-thumbs-up'
		# hide :filter
		edit do
			# For RailsAdmin >= 0.5.0
			field :movie do
		    inline_add false
		    inline_edit false
		  end
			field :rating
			field :comment, :ck_editor
			
			# field :admin_id, :hidden do
	  #     default_value do
	  #       bindings[:view]._current_user.id
	  #     end
	  #   end
		end
		list do
			field :rating do
        filterable false
        searchable false
      end			
			
			field :movie do
        filterable false
        searchable true
      end						
			# field :admin do
			# 	filterable false
			# 	searchable false
			# 	pretty_value do
		 #      value.try(:email)
		 #    end
			# end
			field :user do
				filterable false
				searchable false
				pretty_value do
		      value.try(:email)
		    end
			end
		end
	end

	# config.model CriticsRating do
	# 	navigation_icon 'icon-thumbs-up'

	# 	parent Movie
	# 	edit do
	# 		# For RailsAdmin >= 0.5.0
	# 		field :movie do
	# 	    inline_add false
	# 	    inline_edit false
	# 	  end
	# 		field :title
	# 		field :rating	
	# 		field :reviews, :ck_editor	
	# 		field :admin_id, :hidden do
	#       default_value do
	#         bindings[:view]._current_user.id
	#       end
	#     end
	# 	end
	# 	list do
	# 		field :rating do
 #        filterable false
 #        searchable false
 #      end
	# 		field :title do
	# 			filterable false
	# 			searchable true
	# 			# pretty_value do
	# 	  #     value.html_safe
	# 	  #   end
	# 		end
	# 		field :movie do
 #        filterable false
 #        searchable true
 #      end			
	# 		field :admin do
	# 			filterable false
	# 			searchable false
	# 			pretty_value do
	# 	      value.try(:email)
	# 	    end
	# 		end
	# 	end
	# end

	config.model User do
		navigation_icon 'icon-user'
		list do
			field :email do
        filterable false
        searchable true
      end			
			field :sign_in_count do
        filterable false
        searchable false
      end			
			field :updated_at do
        filterable false
        searchable false
      end			
			field :username do
        filterable false
        searchable true
      end			
		end
	
		edit do
			field :email
			# field :password
			# field :password_confirmation
			field :last_sign_in_at
			field :last_sign_in_ip
			field :sign_in_count
			field :username do
				read_only true
			end
		end
	end

	config.model MovieType do
		navigation_icon 'icon-star'
		parent Movie
		list do
			field :title do
        filterable false
        searchable true
      end
			field :updated_at do
        filterable false
        searchable false
      end
			field :movies do
        filterable false
        searchable false
        pretty_value do
		      value.count
		    end
      end
		end
		edit do
			field :title
		end
	end

	config.model Genre do
		navigation_icon 'icon-fire'
		parent Movie
		list do
			field :title do
        filterable false
        searchable true
      end
			field :updated_at do
        filterable false
        searchable false
      end
			field :movies do
        filterable false
        searchable false
        pretty_value do
		      value.count
		    end
      end
		end
		edit do
			field :title
		end
	end

	config.model Banner do 
		navigation_icon 'icon-fire'
    edit do 
      field :ad_type
      field :position
      field :order
      field :size
      field :link
      field :text
      field :banner
      field :google_add_js
    end
    list do
    	field :ad_type
    	field :position
    end
  end

	# config.model Banner do
	# 	navigation_icon 'icon-fire'
	# end

	config.actions do
		dashboard                     # mandatory
		index                         # mandatory
		new do
			except ['Review']
		end

		bollywood_hungama do
			only Movie
		end

		latest_movie do
			only Movie
		end
		
		upcoming_movie do
			only Movie
		end

		# export
		# bulk_delete
		# show
		edit
		delete

		# show_in_app

		## With an audit adapter, you can add:
		# history_index
		# history_show
	end
end
