class ReviewsController < ApplicationController
  def new
    @booking = ConsumerRequest.find(params[:booking])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @artist = Artist.find(params[:artist_id])

    @booking = ConsumerRequest.find(params[:booking_id])
    @review.consumer_request = @booking
    @review.artist = @artist
    @review.user = current_user

    if @review.save

      flash[:notice] = "success"
    else
      flash[:alert] = "try again"
    end
    redirect_to :back
  end

  def edit
  end

  def update
    @review = Review.find(params[:review_id])
    @review.update(review_params)
    redirect_to :back
  end

  def destroy
    @review = Review.find(params[:id])
    @artist = @review.artist
    artist_reviews = Review.where(artist_id: @artist.id).map {|review| review.rating.to_f}
    rating = (artist_reviews.reduce(0, :+) - @review.rating)/(artist_reviews.count - 1).to_f
    @artist.update(rating: rating)
    @review.destroy!

    redirect_to :back
  end

  def index
  end

  private
  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
