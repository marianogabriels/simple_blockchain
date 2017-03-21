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
  end

  def try_with_nonce(nonce)
    block.nonce = nonce
    if block.valid_hash?
      return true
    end
  end
end
