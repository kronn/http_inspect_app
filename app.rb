require 'erb'

class HttpInspectApp < Sinatra::Base
  set :environment, ( ENV['RACK_ENV'] || 'development' ).to_sym
  set :root,        File.dirname(__FILE__)
  disable :run

  before do
    @cookie_key = "Zeitpunkt"
    @cookie_value = Time.now.to_s

    @list = env.keys.sort.map do |key|
      "#{key} = #{env[key]}"
    end.join("\n")
  end

  helpers do
    def h(string)
      ERB::Util.html_escape(string)
    end
  end

  get '/' do
    redirect '/index.html'
  end

  get '/text' do
    @list
  end

  get '/text/' do
    redirect '/text'
  end

  get '/html' do
    "<pre>#{h @list}</pre>"
  end

  get '/cookie' do
    response.set_cookie( @cookie_key, @cookie_value )

    "#{@cookie_key} => #{@cookie_value}"
  end
end
