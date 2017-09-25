module UserHelper
  def display_name
     if current_user.is_artist?
      [@consumer_request.artist.first_name, @consumer_request.artist.last_name].join(' ')
     else
      [@consumer_request.consumer.first_name, @consumer_request.consumer.last_name].join(' ')
     end
  end

  def whos_message(m)
     m.user == current_user ? 'current_user' : 'other_user'
  end
end
