module RailsAdmin
	class MainController < RailsAdmin::ApplicationController
		include ActionView::Helpers::TextHelper
		include RailsAdmin::MainHelper
		include RailsAdmin::ApplicationHelper

		layout :get_layout

		before_filter :get_model, except: RailsAdmin::Config::Actions.all(:root).collect(&:action_name)
		before_filter :get_object, only: RailsAdmin::Config::Actions.all(:member).collect(&:action_name)
		before_filter :check_for_cancel


		RailsAdmin::Config::Actions.all.each do |action|

			class_eval <<-EOS, __FILE__, __LINE__ + 1
				def #{action.action_name}
					puts "------------------------"
					if "#{action.action_name}" == "edit"
						puts "#{action.action_name}"
						puts "__________"
						puts params["movie"]
						@@cr_edit = params["cr"]
						puts "__________"
						puts @@cr_edit
					end
					puts "------------------------"

					puts  "**************************"
					if "#{action.action_name}" == "new"
						# puts  "#{action.action_name}"
						puts  params["movie"]
						puts "2222222"
						puts params["cr"]
						puts "2222222"
						@@crvalues =  params["cr"]
					end
					puts  "**************************"

					action = RailsAdmin::Config::Actions.find('#{action.action_name}'.to_sym)
					@authorization_adapter.try(:authorize, action.authorization_key, @abstract_model, @object)
					@action = action.with({controller: self, abstract_model: @abstract_model, object: @object})

					puts  "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
					if "#{action.action_name}" == "new"
						puts @object.inspect
					end
					puts  "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"


					fail(ActionNotAllowed) unless @action.enabled?
						@page_name = wording_for(:title)

						instance_eval &@action.controller
					end
			EOS
		end

		def bulk_action
			send(params[:bulk_action]) if params[:bulk_action].in?(RailsAdmin::Config::Actions.all(controller: self, abstract_model: @abstract_model).select(&:bulkable?).collect(&:route_fragment))
		end

		def list_entries(model_config = @model_config, auth_scope_key = :index, additional_scope = get_association_scope_from_params, pagination = !(params[:associated_collection] || params[:all] || params[:bulk_ids]))
			scope = model_config.abstract_model.scoped
			if auth_scope = @authorization_adapter && @authorization_adapter.query(auth_scope_key, model_config.abstract_model)
				scope = scope.merge(auth_scope)
			end
			scope = scope.instance_eval(&additional_scope) if additional_scope
			get_collection(model_config, scope, pagination)
		end

	private

		def get_layout
			"rails_admin/#{request.headers['X-PJAX'] ? 'pjax' : 'application'}"
		end

		def back_or_index
			params[:return_to].presence && params[:return_to].include?(request.host) && (params[:return_to] != request.fullpath) ? params[:return_to] : index_path
		end

		def get_sort_hash(model_config)
			abstract_model = model_config.abstract_model
			params[:sort] = params[:sort_reverse] = nil unless model_config.list.fields.collect { |f| f.name.to_s }.include? params[:sort]
			params[:sort] ||= model_config.list.sort_by.to_s
			params[:sort_reverse] ||= 'false'

			field = model_config.list.fields.detect { |f| f.name.to_s == params[:sort] }
			column = begin
				if field.nil? || field.sortable == true # use params[:sort] on the base table
					"#{abstract_model.table_name}.#{params[:sort]}"
				elsif field.sortable == false # use default sort, asked field is not sortable
					"#{abstract_model.table_name}.#{model_config.list.sort_by}"
				elsif (field.sortable.is_a?(String) || field.sortable.is_a?(Symbol)) && field.sortable.to_s.include?('.') # just provide sortable, don't do anything smart
					field.sortable
				elsif field.sortable.is_a?(Hash) # just join sortable hash, don't do anything smart
					"#{field.sortable.keys.first}.#{field.sortable.values.first}"
				elsif field.association? # use column on target table
					"#{field.associated_model_config.abstract_model.table_name}.#{field.sortable}"
				else # use described column in the field conf.
					"#{abstract_model.table_name}.#{field.sortable}"
				end
			end

			reversed_sort = (field ? field.sort_reverse? : model_config.list.sort_reverse?)
			{sort: column, sort_reverse: (params[:sort_reverse] == reversed_sort.to_s)}
		end

		def redirect_to_on_success

			puts  "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
			if ("#{@action.key}" == "new") && ("#{@model_config.label}" == "Movie")
				# puts @object.id
				# puts @model_config.label
				puts "gere==========="
			
				i = 0
				supplies = []

				puts @@crvalues

				unless @@crvalues[:title].blank?
			
					cr_count =  @@crvalues[:title].length
					
					cr_count.times do
						@@crvalues.each do |key, value|
							supplies << value[i]
						end
						
						j = 0
						@cr_i = CriticsRating.new
						1.times do
							if(j==0)
								@cr_i.title = supplies[j]
								j = j+1
							end 

							if(j==1)
								@cr_i.rating = supplies[j]
								j = j+1
							end 

							if(j==2)
								@cr_i.reviews = supplies[j]
								j = j+1
							end 

							@cr_i.movie_id = @object.id
							@cr_i.save!

						end
						supplies.clear

						i +=1
					end	
				end

				movie = Movie.find(@object.id)
				if movie.critics_ratings.count > 0

					av_cr_rating = movie.critics_ratings
					
					@average_cr_rating = 0.0
					cr_rating = 0.0
					critics_count = 0

					av_cr_rating.each do |cr|
						if cr.title.blank?
							cr.delete
						end
					
						if movie.critics_ratings.count > 0
							critics_count = movie.critics_ratings.count	
							cr_rating = cr_rating + cr.rating					
						end
						
					end

					@average_cr_rating = cr_rating/critics_count	
					movie.update_attributes(:rating => @average_cr_rating)

					puts @average_cr_rating

				end

		

			  puts "gere==========="
				# puts "#{@action.key}"
			end                            
			puts  "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"

			puts "<<<<<<<<<<<<<<<<<<<<<<<<<"
			if ("#{@action.key}" == "edit") && ("#{@model_config.label}" == "Movie")
				puts @@cr_edit
				puts "..........."
				puts @@cr_edit.values.reduce(:zip).map(&:flatten)
				puts "..........."
				puts @@cr_edit.values.transpose.inspect

				Movie.find(@object.id).critics_ratings.each do |cr|
					cr.delete
				end

				eachrow = @@cr_edit.values.transpose

				puts "////////////"

				puts @object.id

				eachrow.each_with_index do |cr, index|

					# if eachrow[index][0].blank?
						puts "newwwwww"
						@cr_index = CriticsRating.new
						cr.each_with_index do |r, ind|
							if(ind == 0)
								@cr_index.title = eachrow[index.to_i][ind.to_i]
							end
							if(ind == 1)
								@cr_index.rating = eachrow[index.to_i][ind.to_i]
							end
							if(ind == 2)
								@cr_index.reviews = eachrow[index.to_i][ind.to_i]
							end

							@cr_index.movie_id = @object.id

							@cr_index.save!

							puts eachrow[index.to_i][ind.to_i]
						end
					# else
					# 	@cr_index = CriticsRating.find(eachrow[index][0])
					# 	puts "updateeeee"
					# 	cr.each_with_index do |r, ind|
					# 		if(ind == 1)
					# 			@cr_index.title = eachrow[index.to_i][ind.to_i]
					# 		end
					# 		if(ind == 2)
					# 			@cr_index.rating = eachrow[index.to_i][ind.to_i]
					# 		end
					# 		if(ind == 3)
					# 			@cr_index.reviews = eachrow[index.to_i][ind.to_i]
					# 		end

					# 		@cr_index.movie_id = @object.id

					# 		@cr_index.save!

					# 		puts eachrow[index.to_i][ind.to_i]
					# 	end
					# end
				end

				av_cr_rating = Movie.find(@object.id).critics_ratings
				movie = Movie.find(@object.id)

				@average_cr_rating = 0.0
				cr_rating = 0.0

				av_cr_rating.each do |cr|
				
					if av_cr_rating.count > 0
						critics_count = av_cr_rating.count	
						cr_rating = cr_rating + cr.rating					
					end
					@average_cr_rating = cr_rating/critics_count	
					movie.update_attributes(:rating => @average_cr_rating)
				end

				puts @average_cr_rating

				puts "////////////"

			end
			puts "<<<<<<<<<<<<<<<<<<<<<<<<<"

			notice = t('admin.flash.successful', name: @model_config.label, action: t("admin.actions.#{@action.key}.done"))
			if params[:_add_another]
				redirect_to new_path(return_to: params[:return_to]), flash: {success: notice}
			elsif params[:_add_edit]
				redirect_to edit_path(id: @object.id, return_to: params[:return_to]), flash: {success: notice}
			else
				redirect_to back_or_index, flash: {success: notice}
			end
		end

		def visible_fields(action, model_config = @model_config)
			model_config.send(action).with(controller: self, view: view_context, object: @object).visible_fields
		end

		def sanitize_params_for!(action, model_config = @model_config, target_params = params[@abstract_model.param_key])
			return unless target_params.present?
			fields = visible_fields(action, model_config)
			allowed_methods = fields.collect(&:allowed_methods).flatten.uniq.collect(&:to_s) << 'id' << '_destroy'
			fields.each { |field|  field.parse_input(target_params) }
			target_params.slice!(*allowed_methods)
			target_params.permit! if target_params.respond_to?(:permit!)
			fields.select(&:nested_form).each do |association|
				children_params = association.multiple? ? target_params[association.method_name].try(:values) : [target_params[association.method_name]].compact
				(children_params || []).each do |children_param|
					sanitize_params_for!(:nested, association.associated_model_config, children_param)
				end
			end
		end

		def handle_save_error(whereto = :new)
			flash.now[:error] = t('admin.flash.error', name: @model_config.label, action: t("admin.actions.#{@action.key}.done").html_safe).html_safe
			flash.now[:error] += %(<br>- #{@object.errors.full_messages.join('<br>- ')}).html_safe

			respond_to do |format|
				format.html { render whereto, status: :not_acceptable }
				format.js   { render whereto, layout: false, status: :not_acceptable  }
			end
		end

		def check_for_cancel
			return unless params[:_continue] || (params[:bulk_action] && !params[:bulk_ids])
			redirect_to(back_or_index, notice: t('admin.flash.noaction'))
		end

		def get_collection(model_config, scope, pagination)
			associations = model_config.list.fields.select { |f| f.type == :belongs_to_association && !f.polymorphic? }.collect { |f| f.association.name }
			options = {}
			options = options.merge(page: (params[Kaminari.config.param_name] || 1).to_i, per: (params[:per] || model_config.list.items_per_page)) if pagination
			options = options.merge(include: associations) unless associations.blank?
			options = options.merge(get_sort_hash(model_config))
			options = options.merge(query: params[:query]) if params[:query].present?
			options = options.merge(filters: params[:f]) if params[:f].present?
			options = options.merge(bulk_ids: params[:bulk_ids]) if params[:bulk_ids]
			model_config.abstract_model.all(options, scope)
		end

		def get_association_scope_from_params
			return nil unless params[:associated_collection].present?
			source_abstract_model = RailsAdmin::AbstractModel.new(to_model_name(params[:source_abstract_model]))
			source_model_config = source_abstract_model.config
			source_object = source_abstract_model.get(params[:source_object_id])
			action = params[:current_action].in?(%w(create update)) ? params[:current_action] : 'edit'
			@association = source_model_config.send(action).fields.detect { |f| f.name == params[:associated_collection].to_sym }.with(controller: self, object: source_object)
			@association.associated_collection_scope
		end
	end
end