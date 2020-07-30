class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.latest.page(params[:page]).per(20).includes(:musicpost, :comment, visitor: { avatar_attachment: :blob })

    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
