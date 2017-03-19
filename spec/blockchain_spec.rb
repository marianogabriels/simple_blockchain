require 'spec_helper'

describe Blockchain do
  describe '.blocks' do
    it 'should be initialized with genesis block' do
      blockchain = Blockchain.new
      expect(blockchain.blocks.first.index).to_not eq(nil)
      expect(blockchain.blocks.first.nonce).to_not eq(nil)
      expect(blockchain.blocks.first.valid?).to eq(true)
      expect(blockchain.blocks.first.nonce).to eq(524288)
    end
  end
end
