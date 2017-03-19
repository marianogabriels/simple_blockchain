class Miner
  attr_accessor :block
  def initialize(block)
    @block = block
  end

  def perform!
    block.calculate_hash
    until block.valid_hash?(block.hash) do
      try_with_nonce(SecureRandom.hex)
    end
  end

  def try_with_nonce(nonce)
    block.nonce = nonce
    block.calculate_hash
    if block.valid_hash?(hash)
      return true
    end
  end
end
