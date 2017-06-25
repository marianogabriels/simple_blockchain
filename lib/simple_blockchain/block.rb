require 'securerandom'
require 'json'
class Block
  attr_accessor :data,:index,:prev,:data,:timestamp,:nonce,:blockchain

  def initialize(args={})
    args = Hash[args.map { |k, v| [k.to_sym, v] }]
    @data = args[:data]
    @timestamp = args[:timestamp]
    @nonce = args[:nonce]
    @blockchain = args[:blockchain] || SimpleBlockchain.blockchain
    self.index = self.blockchain.blocks.count
    raise "no blockchain given" unless @blockchain
  end

  def to_hash
    {
      data: @data,
      timestamp: timestamp,
      hash: hash,
      prev: prev,
      nonce: nonce.to_s,
      index: index
    }
  end

  def genesis?
    index == nil
  end

  def prev
    return nil unless last_block
    return last_block.hash
  end

  def last_block
    return nil if (index - 1) < 0 || index == 0
    blockchain.blocks[index - 1]
  end

  def next_block
    blockchain.blocks[index + 1]
  end

  def hash
    Digest::SHA256.hexdigest(hash_fields.join)
  end

  def header
    [ index , prev , timestamp , nonce ]
  end

  def hash_fields
    [ data  ]  + header
  end

  def mining
    Miner.new(self).perform!
  end

  def valid?
    return false unless valid_hash?
    return true
  end

  def valid_hash?
    hash.start_with? SimpleBlockchain::DIFFICULTY.times.map{|e| '0'}.join
  end
end
