ActionMailer::Base.smtp_settings = {
  :address              => "",
  :port                 => 587,
  :domain               => "artnight.net",
  :user_name            => "beergarden123",
  :password             => "",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
