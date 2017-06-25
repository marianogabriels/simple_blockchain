require "simple_blockchain/version"

require 'simple_blockchain/block'
require 'simple_blockchain/miner'
require 'simple_blockchain/blockchain'
require 'simple_blockchain/connection_handler'
require 'simple_blockchain/protocol'

module SimpleBlockchain
  DIFFICULTY = 1

  def self.blockchain
    @blockchain ? @blockchain : @blockchain = Blockchain.new
  end

  def self.genesis_block(blockchain)
    Block.new(timestamp: 1489908099,
              data: "genesis",
              blockchain: blockchain
             )
  end
  module SimpleBlockchain::Logger
    def self.info(message)
    end
  end
end
