require 'rails_helper'

RSpec.describe PostNotificationJob, type: :job do

  before :each do
    @user = create(:user)
    @user = JSON.parse(@user.to_json)
    @this_user_name  = "Vishal"
  end
  it 'queues the job' do
    expect {
      PostNotificationJob.perform_async(@user, @this_user_name)
    }.to change(PostNotificationJob.jobs, :size).by(1)
  end

  it 'sends notification email' do
    expect(PostNotificationMailer).to receive(:send_notification).with(@user, @this_user_name).and_call_original
    PostNotificationJob.perform_async(@user, @this_user_name)
    PostNotificationJob.drain
  end

  # it 'enqueues the job with retry option' do
  #   retry_count = 2
  #
  #   expect(PostNotificationJob).to receive(:perform_in)
  #                                    .with(Sidekiq::Worker::DEFAULTS['retry'], @user, @this_user_name)
  #                                    .exactly(retry_count).times
  #
  #   retry_count.times do
  #     PostNotificationJob.perform_async(@user, @this_user_name)
  #     PostNotificationJob.drain
  #   end
  # end
end
