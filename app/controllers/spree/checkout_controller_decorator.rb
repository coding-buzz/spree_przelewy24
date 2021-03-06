module Spree
  CheckoutController.class_eval do

    before_action :redirect_for_przelewy24, :only => :update

    private

    def redirect_for_przelewy24
      return unless params[:state] == "payment"

      if params[:order][:payments_attributes].nil?
        flash[:error] = Spree.t('checkout_payment_not_choosed')
        redirect_to checkout_state_path(@order.state)
      else
        @payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
        if @payment_method && @payment_method.kind_of?(PaymentMethod::Przelewy24)
          redirect_to gateway_przelewy24_path(:gateway_id => @payment_method.id, :order_id => @order.id)
        end
      end
    end

  end
end
