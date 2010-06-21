require 'erb'

class HttpInspectApp < Sinatra::Base
  set :environment, ( ENV['RACK_ENV'] || 'development' ).to_sym
  set :root,        File.dirname(__FILE__)
  disable :run

  before do
    @cookie_key = "Zeitpunkt"
    @cookie_value = Time.now.to_s

    @list = env.keys.sort.map do |key|
      next unless key =~ /^[A-Z]/
      "#{key} = #{env[key]}"
    end.compact.join("\n")
    @list << "\n\n"
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

  post '/text' do
    list_and_post = ""
    list_and_post << @list
    list_and_post << request.POST.map do |key, value|
      "  #{key} => #{value}"
    end.compact.flatten.join("\n")
    list_and_post << "\n\n"

    list_and_post
  end
end
