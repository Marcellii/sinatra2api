# frozen_string_literal: true

# sinatra.rb
require 'sinatra'
require 'json'
require 'httparty'

post '/json' do
  hashtag = params['hashtagform'].split(',')
   HTTParty.post("http://ci-slave1.virtapi.org:9494/json", :headers => {'Content-Type'=>'application/json'}, :body => {"hashtags" => hashtag}.to_json)
  redirect '/'
end

post '/jsond' do
	HTTParty.delete("http://ci-slave1.virtapi.org:9494/json")
end

get '/' do
  get_hashtags = HTTParty.get("http://ci-slave1.virtapi.org:9494/json")
  got_hashtag = JSON.load(get_hashtags.body)['hashtags'].join(',')
%Q{
	<form method="post" action="/json">
	<p> Enter here your hashtags: <input type ="text" name ="hashtagform" value=#{got_hashtag}></p>
	<input type="submit">
	</form>
  <form method="post" action="/jsond">
  <button type="submit" value="Submit">Delete</button>
  </form>
 }
end
