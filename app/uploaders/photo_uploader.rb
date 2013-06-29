# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env == 'production'
    storage :fog
  else
    storage :file
  end

  process :resize_to_fit => [800, 800]

  version :thumb do
    process :resize_to_limit => [80, 80]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
