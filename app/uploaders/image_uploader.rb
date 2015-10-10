class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  process resize_to_limit: [800, nil]

  version :thumb do
    process :resize_to_fill => [150,112]
  end

  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
