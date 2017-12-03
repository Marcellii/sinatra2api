# sinatra2api

webfrontpage with sinatra, where user can add, delete or get hashtags

## Usage

### Start sintra2api

```bash
bundle exec ruby main.rb
```

### Understand how it works

Sintra will automatic get all hashtags, if you refresh the page.


What happen in the background, if you refresh the page:
```bash
got_hashtag = JSON.load(get_hashtags.body)['hashtags'].join(',')
```



When you want to add new hashtags, you can find a form field,
where you can add new hashtags, comma seperated. If you
click on **submit**, in the background the following code will 
start:
```bash
HTTParty.post("http://ci-slave1.virtapi.org:9494/json", :headers => {'Content-Type'=>'application/json'}, :body => {"hashtags" => hashtag}.to_json)
```
If you have entered some hashtags and click on submit, the script
will redirect you to the main page, where automatically 
the get script run.



To delete all hashtags, you can use the **delete** button.
It will run the following code in the background:
```bash
HTTParty.delete("http://ci-slave1.virtapi.org:9494/json")
```
