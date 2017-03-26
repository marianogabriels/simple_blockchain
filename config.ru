require 'sinatra'
require './lib/simple_blockchain'
require 'pry'

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

run Application
