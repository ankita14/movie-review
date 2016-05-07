# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
	include CarrierWave::MiniMagick
	# Include RMagick or MiniMagick support:
	# include CarrierWave::RMagick
	# include CarrierWave::MiniMagick

	# Choose what kind of storage to use for this uploader:
	storage :file
	# storage :fog

	# Override the directory where uploaded files will be stored.
	# This is a sensible default for uploaders that are meant to be mounted:
	def store_dir
		"uploads/#{model.class.to_s.underscore}"
	end

	# Process files as they are uploaded:
	# process :scale => [300, 600]
	#
	# def scale(width, height)
	#   # do something
	# end

	# Create different versions of your uploaded files:
	version :thumb do
		process :resize_to_fit => [315, 200]
	end

	version :indexThumb do
		process :resize_to_fit => [800, 500]
	end

	version :mobile do
	  process resize_to_fit: [150, 150]
	end

	# Add a white list of extensions which are allowed to be uploaded.
	# For images you might use something like this:
	def extension_white_list
		%w(jpg jpeg gif png)
	end

end
