json.array! scope do |record|
  json.partial! 'artist', resource: record
end