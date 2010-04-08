class HttpInspectApp < Sinatra::Base
  set :environment, ( ENV['RACK_ENV'] || 'development' ).to_sym
  set :root,        File.dirname(__FILE__)
  disable :run

  before do
    header_keys = [
      :accept_encoding, :content_charset, :content_length, :cookies,
      :host, :ip, :media_type, :media_type_params, :params,
      :query_string, :referer, :request_method, :scheme,
      :url, :user_agent
    ]
    header_array = header_keys.map do |key|
      "#{key}: #{request.send(key).inspect}"
    end
    @header_list = header_array.join("\n")
  end

  get '/text' do
    @header_list
  end

  get '/html' do
    "<pre>#{@header_list}</pre>"
  end

  get '/cookie' do
    "TO BE DONE"
  end
end
