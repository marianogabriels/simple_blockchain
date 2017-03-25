class Blockchain
  attr_accessor :blocks

  def initialize(opts={})
    @blocks = []
    unless opts[:no_genesis]
      SimpleBlockchain.genesis_block(self)
      @blocks[0].mining
    end
  end

  def add_block(data)
    Block.new(data: data,blockchain: self)
  end
end
