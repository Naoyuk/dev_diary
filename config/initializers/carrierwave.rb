CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:                 ENV['PROVIDER'],
    aws_access_key_id:        ENV['AWS_ACCESS_KEY'],
    aws_secret_access_key:    ENV['AWS_SECRET_KEY'],
    region:                   ENV['AWS_REGION']
  }
  config.fog_directory  = ENV['AWS_BUCKET']
  config.fog_public     = false
  config.cache_dir      = "#{Rails.root}/tmp/uploads"
  config.storage        = :fog
end
