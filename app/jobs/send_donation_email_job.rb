
class SendDonationEmailJob < ActiveJob::Base
  queue_as :default

  require "mandrill"

  def perform(*args)
    # Do something later
    m = Mandrill::API.new
      message = {
        :from_name=> "Puppify",
        :from_email=>"codefordenver@gmail.com",
        :to=> "dviramontes@gmail.com",
        :subject=> "New in #{category.name}: #{video.title}",
        :html=> body,
        :merge_vars => merge_vars,
        :preserve_recipients => false,
        :global_merge_vars => [
          {name: "category", content: category.name},
          {name: "video_title", content: video.title},
          {name: "video_url", content: Rails.application.routes.url_helpers.video_path(video)}
        ]
      }
      m.messages.send message
  end
end

# References
# http://edgeguides.rubyonrails.org/active_job_basics.html
# http://aspiringwebdev.com/e-mail-in-rails-with-mailchimp-and-mandrill-a-comprehensive-guide/
# https://robots.thoughtbot.com/how-to-send-transactional-emails-from-rails-with-mandrill