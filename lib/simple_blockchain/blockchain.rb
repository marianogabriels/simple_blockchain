class Blockchain
  attr_accessor :blocks

  def initialize
    @blocks = []
    @blocks << SimpleBlockchain.genesis_block
    @blocks[0].mining
  end

  def add_block(data)
    block = Block.new(data: data)
    block.prev = blocks[-1].hash
    block.index = blocks.count
    @blocks << block
  end
end
