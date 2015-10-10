json.array!(@listings) do |listing|
  json.extract! listing, :id
  json.url admin_listing_url(listing, format: :json)
end
