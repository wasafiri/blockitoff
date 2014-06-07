module ListsHelper
  def formatted_created_at(list)
    distance_of_time_in_words(list.created_at, Time.now)
  end

  def formatted_updated_at(list)
    distance_of_time_in_words(list.updated_at, Time.now) || "Never"
  end
end
