class SubscriptionsController < SecureController
  def index
    @subscriptions = current_user.subscriptions
  end

  def new
    @publication_id = params[:publication_id]
  end

  def create
    token = params[:stripeToken]

    begin
      SubscriptionCreator.new(current_user, params[:publication_id], token).create_subscription
      flash[:notice] = 'Your subscription is successful'
      redirect_to user_path(current_user.id)
    rescue SubscriptionError => e
      flash[:error] = e
      render '/publications'
    rescue StripeError => e
      flash[:error] = e
      render :new
    end

  end

end
