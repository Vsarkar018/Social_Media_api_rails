class MailerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user)
    puts "sidekiq worker running for #{user}"
  end

end