class MatchByTag
  def intitialize(search_tags, artists)
    @search_tags = search_tags
    @artists = artists
  end

  def call
    rank_by(given_concordace(user_processed_tags))
  end

  private

  def user_processed_tags
    @search_tags.split
  end

  def given_concordance(user_tags)
    association_map = {}
    @artists.each do |artist|
      art_tags = artist.tags.split
      concordance = user_tags && art_tags
      association_map[artist] = concordance
    end
    association_map
  end

  def rank(map)
    map.to_a.sort_by { |i| i[1] }.map { |j| j[0]}
  end
end
