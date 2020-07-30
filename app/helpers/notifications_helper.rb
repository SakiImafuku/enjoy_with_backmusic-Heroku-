module NotificationsHelper
  def unchecked_notifications
    @notifications = current_user.passive_notifications.find_by(checked: false)
  end
end