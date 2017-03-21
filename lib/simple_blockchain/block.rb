require 'securerandom'
class Block
  attr_accessor :data,:index,:prev,:data,:timestamp,:nonce,:blockchain

  def initialize(args={})
    @data = args[:data]
    @index = args[:index]
    @prev = args[:prev]
    @timestamp = args[:timestamp]
    @hash = args[:hash]
    @data = args[:data]
  end

  def prev
    return @prev if @prev
    last_block.hash
  end

  def last_block
    blockchain.blocks[index - 1]
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
    return false unless valid_header?
    return false unless valid_hash?
    return true
  end

  def valid_header?
    !(header.any?{|e| e.nil?})
  end

  def valid_hash?
    return false unless valid_header?
    return false unless hash
    return false unless Digest::SHA256.hexdigest(hash_fields.join) == hash
    if blockchain
      return false if prev != last_block.hash
    end
    hash.start_with? SimpleBlockchain::DIFFICULTY.times.map{|e| '0'}.join
  end
end
