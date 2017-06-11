require 'sinatra'
require './lib/simple_blockchain'
require 'pry'
require 'socket'

class Application < Sinatra::Base
  @@blockchain = Blockchain.new

  get '/blocks' do
    return @@blockchain.blocks.map{|block| block.to_hash }.to_json
  end

  post '/block' do
    req_body = JSON.parse request.body.read
    block = Block.new(data: req_body['data'],
                      blockchain: @@blockchain
                     )

    block.mining
  end
end



def run(opts)

  EM.run do

    server  = opts[:server] || 'thin'
    host    = opts[:host]   || '0.0.0.0'
    port    = opts[:port]   || '8181'
    web_app = opts[:app]

    dispatch = Rack::Builder.app do
      map '/' do
        run web_app
      end
    end

    unless ['thin', 'hatetepe', 'goliath'].include? server
      raise "Need an EM webserver, but #{server} isn't"
    end

    Rack::Server.start({
      app:    dispatch,
      server: server,
      Host:   host,
      Port:   port,
      signals: false,
    })
    EventMachine::start_server "127.0.0.1", 8393, SimpleBlockchain::Connection
  end
end


run app: Application.new
