require 'securerandom'
class Block
  attr_accessor :data,:index,:prev,:data,:timestamp,:nonce,:blockchain

  def initialize(args={})
    @data = args[:data]
    @timestamp = args[:timestamp]
    @blockchain = args[:blockchain]
    raise "no blockchain given" unless @blockchain
    @blockchain.blocks << self unless blockchain.blocks.any?{|bb| bb == self } 
    @index = @blockchain.blocks.count - 1
  end

  def genesis?
    index == 0
  end

  def prev
    return 0 if self.genesis?
    return 0 unless last_block
    return last_block.hash
  end

  def last_block
    return nil if genesis?
    raise "no blockchain given" unless blockchain
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
    return false unless Digest::SHA256.hexdigest(hash_fields.join) == hash
    if last_block != nil
      return false if prev != last_block.hash
    end
    hash.start_with? SimpleBlockchain::DIFFICULTY.times.map{|e| '0'}.join
  end
end
