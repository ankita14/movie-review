json.array!(@featured_trailors) do |featured_trailor|
  json.extract! featured_trailor, :id, :movie_id, :position
  json.url featured_trailor_url(featured_trailor, format: :json)
end
