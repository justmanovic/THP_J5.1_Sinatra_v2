require 'bundler'
Bundler.require

get '/hello' do
  '<h1>Hello world ! </h1>'
end

get '/bonjour' do
  '<h1>Bonjour, monde !</h1>'
end

get '/say/*/to/*' do
  # matches /say/hello/to/world
  params['splat'] # => ["hello", "world"]
  puts params["splat"][0]
  puts params["splat"][1]
  '<h1>
  params["splat"][0] + ", " + params["splat"][1]
  </h1>'
end