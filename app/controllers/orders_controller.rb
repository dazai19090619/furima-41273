class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
   gon.public_key = ENV["PAYJP_PUBLIC_KEY"]

   @order_address = OrderAddress.new

   if @item.user_id == current_user.id || @item.order.present?
    redirect_to root_path
   end
 end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]

      begin
        Payjp::Charge.create(
          amount: @item.price,
          card: order_params[:token],
          currency: "jpy"
        )

        @order_address.save
        redirect_to root_path

      rescue Payjp::Error
        flash.now[:alert] = "決済に失敗しました"
        render :index, status: :unprocessable_entity
      end

    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end