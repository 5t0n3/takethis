require 'sinatra'
require 'securerandom'

configure do
  set :token, ENV['TOKEN']
end

post '/upload' do
  unless params['token'] == settings.token and params['file']
    halt 400, 'bad request'
  end

  # write file to random uuid location
  fileid = SecureRandom.uuid
  path = File.join('attachments', fileid)
  
  IO.copy_stream(params['file']['tempfile'], path)

  fileid
end

get '/:fileid' do
  path = File.join('attachments', params['fileid'])

  unless File.exist?(path)
    halt 404
  end

  File.read(path)
end

not_found do
  'not found'
end

error do
  'something went wrong :('
end
