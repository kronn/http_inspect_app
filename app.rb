class HttpInspectApp < Sinatra::Base
  set :environment, ( ENV['RACK_ENV'] || 'development' ).to_sym
  set :root,        File.dirname(__FILE__)
  disable :run

  before do
    @list = env.keys.sort.map do |key|
      "#{key} = #{env[key]}"
    end.join("\n")
  end

  get '/text' do
    @list
  end

  get '/html' do
    "<pre>#{@list}</pre>"
  end

  get '/cookie' do
    @key = "Zeitpunkt"
    @value = Time.now.to_s
    response.set_cookie( @key, @value )

    "<pre>#{@key} => #{@value}</pre>"
  end
end
