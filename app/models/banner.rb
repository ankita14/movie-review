class Banner < ActiveRecord::Base
	mount_uploader :banner, BannerUploader
	validates :ad_type, presence: true
	validates :position, presence: true
	validates :order, numericality: { greater_than_or_equal_to: 1 }

	def position_enum
		['Header', 'Sidebar', 'Movie Detail Top', 'Movie Detail Bottom', 
			'Index Top', 'Index In between', 'Index Bottom', 'Genre Top', 'Genre Bottom', 
			'Top Rated Top', 'Top Rated In between', 'Top Rated Bottom', 'Upcoming Bottom', 'Upcoming In between', 'Upcoming Top', 
			'Page Top', 'Page Bottom', 'Latest Top', 'Latest In between', 'Latest Bottom']
	end

	def size_enum
		['300*600', '300*250', '336*280', '320*50', '728*90', '160*600']
	end

	def ad_type_enum
		['Text', 'Banner', 'Google Ad']		
	end
end
