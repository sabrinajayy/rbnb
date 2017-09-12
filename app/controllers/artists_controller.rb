class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]
  before_action :set_artist, only: [:show]

  def index
    @artists = Artist.all
  end

  def show

  end

  def search
    @service = params[:service]
    @results = Artist.where(service: @service)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_artist
    @artist = Artist.find(params[:id])
  end


end
