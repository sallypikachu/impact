Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['LINKEDIN_CLIENT_KEY'], ENV['LINKEDIN_CLIENT_SECRET']
  provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET']
  provider :twitter, ENV['TWITTER_APP_KEY'], ENV['TWITTER_APP_SECRET']
end
