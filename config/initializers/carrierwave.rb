CarrierWave.configure do |config|
    # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
    #
    # $ heroku config:add S3_KEY=your_s3_access_key S3_SECRET=your_s3_secret S3_REGION=eu-west-1 S3_ENDPOINT=https://s3-eu-west-1.amazonaws.com S3_BUCKET_NAME=hitchlog.heroku.com
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
  
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end
 
  config.cache_dir = "#{Rails.root}/tmp/uploads"  
end

