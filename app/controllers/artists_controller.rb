class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :index, :show]
  before_action :set_artist, only: [:show]

  def index
    # all artists
    @artists = Artist.all
  end

  def show
    # single artist profile
  end

  def search
    # filtered artists results
    @service = params[:service]
    @results = Artist.where(service: @service)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_artist
    @artist = Artist.find(params[:id])
  end


end
