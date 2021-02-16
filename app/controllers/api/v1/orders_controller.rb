class Api::V1::OrdersController < ApplicationController
   def show
    order=Order.find_by(verification: params[:id])
    if order
      sum_order=OrderDetail.where(verification: params[:id]).sum(:price).to_i
      order_data=OrderDetail.select("article_number,name,category,price,points").where(verification: params[:id]).to_a
      if order.customer_id.to_i > 0
          customer=Customer.find_by(id: order.customer_id.to_i)
      end
      render json: {order: order, user: customer, Total: sum_order, data: order_data}
    else
      render json: { message: "Missing order"},status: :no_content
    end
  end
  
  
  def create
    if(params.has_key?(:data) )
      param_data=params
      data=param_data['data']

      if !data.empty?
        verification_id=SecureRandom.uuid.to_s
        customer=param_data['customer_id'].to_i
        used_points=params['used_points'].to_i
        data.each do |t|
          t['verification']=verification_id
        end
        order_details=OrderDetail.insert_all!(data)

        order=add_order(verification_id,customer,used_points)

        render json: {order: order,  data: order_details},status: :ok
      else
      render json: {data: data, message: "No incoming data"},status: :bad_request
      end
    else
      render json: {data: data, message: "Missing param data"},status: :bad_request
    end
  end


  ### Private
  
  def add_order(verification,customer_id,used_points)
    total=OrderDetail.find_by_sql(["SELECT COALESCE(SUM(price),0) AS price, COALESCE(SUM(points),0) AS points from order_details where verification =?", verification])
    # puts total
    amount=total[0].price.to_i
    points=total[0].points.to_i
    if used_points>amount # inte använda fler poäng än summan på ordern
      used_points=amount
    end
    
    if customer_id.to_i > 0 and Customer.exists?(id: customer_id.to_i)
      customer=Customer.find_by(id: customer_id)
      current_points=customer["points"]
      if current_points<used_points
        used_points=current_points
       new_points=points
      else
       new_points=current_points - used_points + points
      end
      customer["points"]=new_points
      customer.save
    else
      customer_id=0
    end
    order=Order.create(verification:verification,customer_id:customer_id,amount:amount,used_points: used_points)
  
  end


  def orders_parameters
        params.permit(:verification, :customer_id, :article_number, :name, :category, :price, :media, :points, :cust_no)
  end


 
end
