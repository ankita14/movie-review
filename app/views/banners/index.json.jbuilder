json.array!(@banners) do |banner|
  json.extract! banner, :id, :image, :link, :text, :position
  json.url banner_url(banner, format: :json)
end
