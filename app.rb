class HttpInspectApp < Sinatra::Base
  set :environment, ( ENV['RACK_ENV'] || 'development' ).to_sym
  set :root,        File.dirname(__FILE__)
  disable :run

  get '/' do
    header_keys = [
      :accept_encoding, :content_charset, :content_length, :cookies,
      :host, :ip, :media_type, :media_tyoe_params, :params,
      :query_string, :referer, :request_method, :scheme,
      :url, :user_agent
    ]
    header_array = header_keys.map do |key|
      "#{key}: #{request[key]}"
    end
    header_array.join("\n")
  end
end
