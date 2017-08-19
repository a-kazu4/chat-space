json.array! @messages do |message|
  json.id    message.id
  json.name  message.user.name
  json.body  message.body
  json.image message.image.url(:thumb)
  json.time  message.created_at.strftime('%Y/%m/%d %H:%M:%S')
end
