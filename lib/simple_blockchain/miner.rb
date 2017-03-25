class Miner
  attr_accessor :block
  def initialize(block)
    @block = block
  end

  def perform!
    @counter = 1
    until block.valid_hash? do
      block.timestamp = Time.now.to_i unless block.timestamp
      try_with_nonce(@counter)
      @counter+=@counter
    end
    if block.blockchain 
      block.next_block.prev = block.hash if block.next_block
    end
  end

  def try_with_nonce(nonce)
    block.nonce = nonce
    if block.valid_hash?
      return true
    end
  end
end
