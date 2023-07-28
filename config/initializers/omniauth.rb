Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '153717271263-q2emfdj7u2uafqa4l471o3r5nikru5v1.apps.googleusercontent.com', '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'
end
