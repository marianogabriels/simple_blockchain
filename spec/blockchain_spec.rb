require 'spec_helper'

describe Blockchain do
  let(:blockchain){ Blockchain.new }
  describe '.blocks' do
    it 'should be initialized with genesis block' do
      expect(blockchain.blocks.first.index).to_not eq(nil)
      expect(blockchain.blocks.first.nonce).to_not eq(nil)
      expect(blockchain.blocks.first.valid?).to eq(true)
    end
  end

  describe 'add_block' do
    before(:each){ blockchain.add_block("lalalala") }
    it do
      expect(blockchain.blocks.count).to eq(2)
      expect(blockchain.blocks[0].valid?).to eq(true)
      blockchain.blocks[1].mining
      expect(blockchain.blocks[1].valid?).to eq(true)
    end

    it 'should save prev block' do
      expect(blockchain.blocks[1].prev).to_not be_nil
    end

    it 'block.valid? when prev block is invalid' do
    end

    it 'should assign blockchain to block' do
      expect(blockchain.blocks[1].blockchain).to_not eq(nil)
    end
  end
end
