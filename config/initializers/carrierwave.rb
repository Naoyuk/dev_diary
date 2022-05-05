CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:                 'AWS',
    aws_access_key_id:        Rails.application.credentials.AWS_ACCESS_KEY,
    aws_secret_access_key:    Rails.application.credentials.AWS_SECRET_KEY,
    region:                   'us-east-1'
  }
  config.fog_directory  = Rails.application.credentials.AWS_BUCKET
  config.fog_public     = false
  config.cache_dir      = "#{Rails.root}/tmp/uploads"
  config.storage        = :fog
end
