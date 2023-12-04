class PostNotificationJob
  include Sidekiq::Worker
  sidekiq_options retry: true
  def perform(user,this_user_name)
    PostNotificationMailer.send_notification(user,this_user_name).deliver_later
  end
end
