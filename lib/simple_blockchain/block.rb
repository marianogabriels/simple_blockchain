require 'securerandom'
class Block
  attr_accessor :data,:index,:prev,:hash,:data,:timestamp,:nonce

  def initialize(args={})
    @data = args[:data]
    @index = args[:index]
    @prev = args[:prev]
    @timestamp = args[:timestamp]
    @hash = args[:hash]
    @data = args[:data]
  end

  def calculate_hash
    @hash = Digest::SHA256.hexdigest(data.to_s + index.to_s + prev.to_s + timestamp.to_s + nonce.to_s)
  end

  def mining
    Miner.new(self).perform!
  end

  def valid?
    return false unless nonce
    return false unless hash
    return false unless valid_hash?(hash)
    return true
  end

  def valid_hash?(vhash)
    SimpleBlockchain::DIFFICULTY.times do |n| 
      unless vhash[n] == "0"
        return false
      end
    end
    return true
  end
end
