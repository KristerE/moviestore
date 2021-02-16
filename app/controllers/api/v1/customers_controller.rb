class Api::V1::CustomersController < ApplicationController

  def index
    customers=Customer.all 
    if customers
      render json: {status: 'SUCCESS', message:'Get customers',data:customers},status: :ok
    else
      render json: {status: 'ERROR', message:'No customers',data:customers},status: :unprocessable_entity
    end 
  end

  def show
    customer=Customer.find_by(id:params[:id])
    if customer
      render json: {status: 'SUCCESS', message:'Get customer',data:customer},status: :ok
    else
      render json: {status: 'ERROR', message:'Customer not found',data:customer},status: :unprocessable_entity
    end   
 end

 def update
    customer=Customer.find_by(id:params[:id])
    if customer.update(customer_params)
      render json: {status: 'SUCCESS', message:'Updated customer',data:customer},status: :ok
    else
      render json: {status: 'ERROR', message:'Customer not updated',data:params},status: :unprocessable_entity
    end
  end

  def create
    customer=Customer.new(customer_params)

    if customer.save
      render json: {status: 'SUCCESS', message:'Customer saved',data:customer},status: :ok
    else
      render json: {status: 'ERROR', message:'Customer not saved',data:customer},status: :unprocessable_entity
    end
  end

  private
  def customer_params    
    params.permit(:name,:address,:points)
  end

end
