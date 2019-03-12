class OrdersUserSessionsController < ApplicationController
  def check_user
    @book_ids = params[:order][:book_ids].reject { |id| id == '' }

    unless params[:customer_email].present?
      @order = Order.new
      @order.errors[:base] << "Customer can't be blank"
      render 'orders/new'
    end

    if User.exists?(email: params[:customer_email])
      redirect_to new_orders_user_session_path(
        customer_email: params[:customer_email],
        book_ids: @book_ids
      )
    else
      OrderFactory.create(
        customer_email: params[:customer_email],
        book_ids: params[:order][:book_ids]
      )
    end
  end

  def new
    @order = Order.new
    @book_ids = params[:book_ids]
    @customer_email = params[:customer_email]
  end

  def create
    user = User.find_for_authentication(email: params[:customer_email])
    user = user&.valid_password?(params[:password]) ? user : nil
    sign_in(user, scope: :user)

    OrderFactory.create(
      customer_email: params[:customer_email],
      book_ids: params[:order][:book_ids]
    )

    redirect_to orders_path
  end
end
