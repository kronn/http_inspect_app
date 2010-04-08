require 'erb'

class HttpInspectApp < Sinatra::Base
  set :environment, ( ENV['RACK_ENV'] || 'development' ).to_sym
  set :root,        File.dirname(__FILE__)
  disable :run

  before do
    @list = env.keys.sort.map do |key|
      "#{key} = #{env[key]}"
    end.join("\n")
  end

  helpers do
    def h(string)
      ERB::Util.html_escape(string)
    end
  end

  get '/text' do
    @list
  end

  get '/html' do
    "<pre>#{h @list}</pre>"
  end

  get '/cookie' do
    @key = "Zeitpunkt"
    @value = Time.now.to_s
    response.set_cookie( @key, @value )

    "<pre>#{@key} => #{@value}</pre>"
  end
end
