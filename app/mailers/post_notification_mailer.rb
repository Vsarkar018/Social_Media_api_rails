  class PostNotificationMailer < ApplicationMailer
    def send_notification(user,this_user_name)
      @user = user
      @this_user_name =  this_user_name
      mail(to: @user['email'], subject: "Notification for post")
    end
  end
