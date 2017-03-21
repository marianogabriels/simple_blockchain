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
    SimpleBlockchain::DIFFICULTY.times do |n| 
      unless hash[n] == "0"
        return false
      end
    end
    return true
  end
end
