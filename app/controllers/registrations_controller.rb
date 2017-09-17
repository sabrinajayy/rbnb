class RegistrationsController < Devise::RegistrationsController

  def create
    super do
      # raise
      if params[:user][:Sign_up_as_a] == "artist"
        Artist.create(user_id: resource.id)
      else
        Consumer.create(user_id: resource.id)
      end
    end
  end

  protected

  def after_sign_up_path_for(resource)
    # raise
      if resource.artist
        # edit_artist_path(resource.artist.id)
        new_artist_path
      else
        edit_consumer_path(resource.consumer.id)
      end

  end

end
