class SubscriptionsController < SecureController
  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    subscription = Subscription.new(publication_id: params[:publication_id], user_id: current_user.id)
    if subscription.save
      redirect_to root_path, flash[:success] => 'Your subscription is successful'
    else
      render '/publications', flash[:error] => 'Please try again, there has been an error'
    end
  end
end
