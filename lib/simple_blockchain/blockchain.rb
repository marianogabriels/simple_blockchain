class Blockchain
  attr_accessor :blocks

  def initialize
    @blocks = []
    @blocks << SimpleBlockchain.genesis_block
    @blocks[0].mining
  end

  def add_block(data)
  end

end
