require "simple_blockchain/version"

require 'simple_blockchain/block'
require 'simple_blockchain/miner'
module SimpleBlockchain
  DIFFICULTY = 1
  # Your code goes here...
  def self.genesis_block
    Block.new(index: 1,
              prev: 0,
              timestamp: 1489908099,
              data: "genesis"
             )
  end
end
