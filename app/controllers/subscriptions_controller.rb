class SubscriptionsController < SecureController
  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    subscription = Subscription.new(publication_id: params[:publication_id], user_id: current_user.id)
    if subscription.save
      flash[:success] = 'Your subscription is successful'
      redirect_to user_path(current_user.id)
    else
      render '/publications', flash[:error] => 'Please try again, there has been an error'
    end
  end
end