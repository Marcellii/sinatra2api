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
  redirect '/'
end

get '/' do
  get_hashtags = HTTParty.get("http://ci-slave1.virtapi.org:9494/json")
  got_hashtag = JSON.load(get_hashtags.body)['hashtags'].join(',')
%Q{
  <!-- Function for remove the spaces in the input field -->
  <script language="javascript" type="text/javascript">
  function removeSpacesfromstring(string) 
  {
  return string.split(' ').join('');
  }
  </script>
  <!-- Input field for hashtags -->
	<form method="post" action="/json">
	<p> Enter here your hashtags: <input type ="text" onblur ="this.value=removeSpacesfromstring(this.value);" name ="hashtagform" value=#{got_hashtag}></p>
	<input type="submit">
	</form>
  <!-- delete button for the hashtags -->
  <form method="post" action="/jsond">
  <button type="submit" value="Submit">Delete</button>
  </form>
 }
end
