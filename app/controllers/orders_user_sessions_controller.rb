class OrdersUserSessionsController < ApplicationController
  def check_user
    if User.exists?(email: params[:customer_email])
      allow_user_to_sign_in and return
    end

    @order = new_order

    if @order.save
      redirect_to orders_path
    else
      @order.book_ids = @order.line_items.map(&:book_id)
      render 'orders/new'
    end
  end

  def new
    @order = Order.new(book_ids: params[:book_ids])
    @customer_email = params[:customer_email]
  end

  def create
    sign_in_user
    new_order.save
    redirect_to orders_path
  end

  private

  def allow_user_to_sign_in
    redirect_to new_orders_user_session_path(
      customer_email: params[:customer_email],
      book_ids: params[:order][:book_ids]
    )
  end

  def new_order
    OrderFactory.build(
      customer_email: params[:customer_email] || current_user.email,
      book_ids: params[:order][:book_ids]
    )
  end

  def sign_in_user
    user = User.find_for_authentication(email: params[:customer_email])
    user = user&.valid_password?(params[:password]) ? user : nil
    sign_in(user, scope: :user)
  end
end
