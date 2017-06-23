class CustomersController < ApplicationController
  SORT_FIELDS = %w(name registered_at postal_code)

  before_action :parse_query_args

  def index
    if @sort
      data = Customer.all.order(@sort)
    else
      data = Customer.all
    end

    data = data.paginate(page: params[:p], per_page: params[:n])

    render json: data.as_json(
      only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit],
      methods: [:movies_checked_out_count, :current_rentals]
    )
  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: customer.as_json, status: :ok
    else
      render json: {errors: {customer: ["Unable to add #{params[:name]} to custokmer database"]} }
    end

  end

private

def customer_params
  params.require(:customer).permit(:name, :phone, :postal_code)
end

  def parse_query_args
    errors = {}
    @sort = params[:sort]
    if @sort and not SORT_FIELDS.include? @sort
      errors[:sort] = ["Invalid sort field '#{@sort}'"]
    end

    unless errors.empty?
      render status: :bad_request, json: { errors: errors }
    end
  end
end
