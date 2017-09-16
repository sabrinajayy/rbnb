class ReviewsController < ApplicationController
  # before_action :set_artist, only: [ :edit, :update]
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @artist = Artist.find(params[:artist_id])
    # @consumer_request = ConsumerRequest.find(params[:consumer_request_id])

    if @review.save
      respond_to do |format|
        format.html { redirect_to artist_path(@artist) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'artists/show' }
        format.js
      end
    end
  end


  def update
  end



  private
  def review_params
    params.require(:review).permit(:title, :content)
  end
end
