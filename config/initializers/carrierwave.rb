CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1' #東京リージョン
  }

    case Rails.env
    when 'production'
        config.fog_directory  = 'raynee-production'
        config.asset_host = 'https://s3.amazonaws.com/raynee-production'
    end
end