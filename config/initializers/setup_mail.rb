ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "artnight.net",
  :user_name            => "beergarden123",
  :password             => "coffeebar",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
