class ConsumersController < ApplicationController
  before_action :set_consumer, only: [:show, :destroy, :update, :edit]

  def index
    # all users - not necessary
    # @consumers = Consumer.all
  end

  def show
    # single user profile - will render view
    @requests = ConsumerRequest.where(user_id: current_user.id)
    @confirmed = @requests.select { |request| request.status == 'confirmed'}
    @pending = @requests.select { |request| request.status == 'unconfirmed'}
  end

  def new
    # new consumer object and render form
    @consumer = Consumer.new
  end

  def create
    # send form parameters
    # @consumers = Consumer.all
    @consumer = Consumer.new(consumer_params)
    if @consumer.save
      redirect_to consumer_path(@consumer)
    else
      render 'consumers/new'
    end
  end

  def destroy
    # delete your own profile
    @consumer.destroy!
  end

  def edit
    # supply form with existing consumer object
  end

  def update
    @consumer.update(consumer_params)
    redirect_to consumer_path(@consumer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_consumer

    @consumer = current_user.consumer

  end

  def consumer_params
    params.require(:consumer).permit(:name, :city, :phone_number, :instagram, :profile_img, :profile_img_cache)
  end

  def prettify_dates(results_array)
    results_array.each do |result|
      result.date = result.date
    end
  end

end
