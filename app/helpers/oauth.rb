def oauth_consumer
  raise RuntimeError, "You must set CONSUMER_KEY and CONSUMER_SECRET in your server environment." unless ENV['CONSUMER_KEY'] && ENV['CONSUMER_SECRET']
  @consumer ||= OAuth::Consumer.new(
    ENV['CONSUMER_KEY'],
    ENV['CONSUMER_SECRET'],
    :site => "https://api.twitter.com"
  )
end

def request_token
  if not session[:request_token]
    # this 'host_and_port' logic allows our app to work both locally and on Heroku
    host_and_port = request.host
    host_and_port << ":9393" if request.host == "localhost"

    # the `oauth_consumer` method is defined above
    session[:request_token] = oauth_consumer.get_request_token(
      :oauth_callback => "http://#{host_and_port}/auth"
    )
  end
  session[:request_token]
end
