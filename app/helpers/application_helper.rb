module ApplicationHelper
  
    def send_email(from_email, to_email, subject, message)
      RestClient.post "https://api:#{ENV['MAILGUN_API_KEY']}"\
      "@api.mailgun.net/v2/samples.mailgun.org/messages",
      :from => from_email,
      :to => to_email,
      :subject => subject,
      :text => message
    end

end
