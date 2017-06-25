class Blockchain
  attr_accessor :blocks

  def initialize(opts={})
    @blocks = []
    unless opts[:no_genesis]
      genesis = SimpleBlockchain.genesis_block(self)
      genesis.mining
      blocks << genesis
    end
  end

  # build, mining and push block to blockchain
  def add_block(data)
    block = Block.new(data: data,blockchain: self)
    block.mining
    return blocks << block  if data.is_a? String
  end

  #sync last block into current blockchain
  def sync_block(block)
    block.valid?
  end
end
