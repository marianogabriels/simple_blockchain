require "simple_blockchain/version"

require 'simple_blockchain/block'
require 'simple_blockchain/miner'
require 'simple_blockchain/blockchain'

module SimpleBlockchain
  DIFFICULTY = 1
  def self.genesis_block(blockchain)
    Block.new(timestamp: 1489908099,
              data: "genesis",
              blockchain: blockchain
             )
  end
end
