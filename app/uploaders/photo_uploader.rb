# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  #include CarrierWave::RMagick

  if Rails.env == 'test' || Rails.env == 'cucumber'
    storage :file
  else
    storage :fog
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
