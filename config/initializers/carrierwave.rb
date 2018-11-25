CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  else
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET'],
      :region                => ENV['S3_REGION'],
      :host                  => ENV['S3_BUCKET_NAME'],
      :endpoint              => ENV['S3_ENDPOINT']
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME']
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}

    config.fog_provider = 'fog/aws'                        # required
    config.storage = :fog
  end
end

