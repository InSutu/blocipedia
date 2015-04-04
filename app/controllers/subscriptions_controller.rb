class SubscriptionsController < ApplicationController

  def new
    #puts "#{ENV['stripe_publishable_key']}"
    #puts '*'*20
    #puts ENV['test']
    @stripe_btn_hash = {
      script: "src='https://checkout.stripe.com/checkout.js' class='stripe-button' data-key= #{ENV['stripe_publishable_key']} ",
      plan: {
        premium: "premium",
        premium_info: "data-description='Premium - $19.99 (Monthly)' data-panel-label='Subscribe' data-label='Subscribe'",
        free: "free",
        free_info: "data-description='Reader - Free' data-panel-label='Subscribe' data-label='Subscribe'"
      }
    }
  end

  def create
    #Amount in cents
    @plan= params[:plan]
     if current_user.stripe_id.nil?
      customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken],
        plan: @plan
        )
        current_user.update_attributes(stripe_id: customer.id, stripe_plan_id: customer.subscriptions.first.id, sub_type: @plan)
     else
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
        subscription = customer.subscriptions.retrieve(current_user.stripe_plan_id)
        subscription.plan = params[:plan]
        subscription.save
      end 

      if params[:plan]=='premium'
        current_user.update_attributes(role: 'premium',sub_type: params[:plan])
      
      else
        current_user.update_attributes(role: 'free',sub_type: params[:plan])
      end

    redirect_to root_path

    # @amount = 500

    # customer = Stripe::Customer.create(
    #   :email => 'example@stripe.com',
    #   :card  => params[:stripeToken]
    # )

    # charge = Stripe::Charge.create(
    #   :customer    => customer.id,
    #   :amount      => @amount,
    #   :description => 'Rails Stripe customer',
    #   :currency    => 'usd'
    # )

  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to root_path
  end

  def edit
    @customer = Stripe::Customer.retrieve("#{current_user.stripe_plan_id}")
  end

  def update
    @customer = Stripe::Customer.retrieve("#{current_user.stripe_plan_id}")
    subscription = customer.subscriptions.retrieve(current_user.stripe_plan_id)
    subscription.plan = params[:plan]
    subscription.save
  end

end
