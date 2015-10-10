class CoverImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  
  process resize_to_limit: [800, nil]

  version :thumb do
    process :resize_to_fill => [75,75]
  end


  def resize_to_width(width, height)
    manipulate! do |img|
      if img.columns >= width
        img.resize(width)
      end
      img = yield(img) if block_given?
      img
    end
  end

  # before :cache, :capture_size_before_cache # callback, example here: http://goo.gl/9VGHI
  # def capture_size_before_cache(new_file)
  #   if model.image_width.nil? || model.image_height.nil?
  #     model.image_width, model.image_height = `identify -format "%wx %h" #{new_file.path}`.split(/x/).map { |dim| dim.to_i }
  #   end 
  # end
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end


end