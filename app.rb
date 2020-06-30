require 'sinatra'
require "sinatra/cookies"

get '/' do
  erb :index
end

# No Header
get "/images/1.jpg" do
  counter = cookies[:image1count].to_i
  response.set_cookie(:image1count, value: counter+1, path: "/", expires: Time.now + 3600 * 24)
  # response.headers['Cache-Control'] = 'max-age=31556952, public, immutable'
  content_type :jpeg
  send_file "images/image.jpg"
end

# Cached
get "/images/2.jpg" do
  counter = cookies[:image2count].to_i
  response.set_cookie(:image2count, value: counter+1, path: "/", expires: Time.now + 3600 * 24)
  response.headers['Cache-Control'] = 'max-age=31556952, public, immutable'
  content_type :jpeg
  send_file "images/image.jpg"
end

# Private
get "/images/3.jpg" do
  counter = cookies[:image3count].to_i
  response.set_cookie(:image3count, value: counter+1, path: "/", expires: Time.now + 3600 * 24)
  response.headers['Cache-Control'] = 'private'
  content_type :jpeg
  send_file "images/image.jpg"
end

# No-Cache
get "/images/4.jpg" do
  counter = cookies[:image4count].to_i
  response.set_cookie(:image4count, value: counter+1, path: "/", expires: Time.now + 3600 * 24)
  response.headers['Cache-Control'] = 'no-cache'
  content_type :jpeg
  send_file "images/image.jpg"
end

# Private redirect to cached image
get "/images/5.jpg" do
  counter = cookies[:image5count].to_i
  response.set_cookie(:image5count, value: counter+1, path: "/", expires: Time.now + 3600 * 24)
  response.headers['Cache-Control'] = 'private'
  redirect "images/5-1.jpg?q=#{SecureRandom.hex}", 302
end

get "/images/5-1.jpg" do
  counter = cookies[:image51count].to_i
  response.set_cookie(:image51count, value: counter+1, path: "/", expires: Time.now + 3600 * 24)
  response.headers['Cache-Control'] = 'max-age=31556952, public, immutable'
  content_type :jpeg
  send_file "images/image.jpg"
end