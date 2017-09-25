class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @booking = ConsumerRequest.find(params[:consumers_request_id])
  end

  def create
    @message = Message.new(message_params)
    @artist = Artist.find(params[:artist_id])
    @booking = ConsumerRequest.find(params[:consumers_request_id])
    @message.consumer_request = @booking
    @message.user = current_user
    if @message.save
    else
      flash[:alert] = "message failed to send"
    end
    redirect_to :back
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end
end
