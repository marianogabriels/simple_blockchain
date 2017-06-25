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

  describe 'sync_block' do
    it 'no able to sync unmined block' do
      block = Block.new(data: "hola")
      expect(blockchain.sync_block(block)).to eq(false)
    end

    it 'no able to sync unmined block' do
      block = Block.new(data: "hola")
      block.mining
      expect(blockchain.sync_block(block)).to be_truthy
    end
    it 'invalidates block' do
      block = Block.new(data: "hola")
      blockchain.blocks[-1].nonce = 33
      expect(block.valid?).to eq(false)
    end

    it 'invalidates some block in blockchain' do
      block = Block.new(data: "hola",blockchain: blockchain)
      block.mining
      old_hash = blockchain.blocks[0].hash
      blockchain.blocks[0].nonce = 31
      expect(old_hash).to_not eq(blockchain.blocks[0].hash)
      expect(block.blockchain).to eq(blockchain)
      expect(block.blockchain.blocks[0].valid?).to eq(false)
      expect(block.valid?).to eq(false)
    end
  end

  describe 'add_block' do
    before(:each){ blockchain.add_block("lalalala") }
    it do
      expect(blockchain.blocks.count).to eq(2)
      expect(blockchain.blocks[-1].index).to eq(1)
      expect(blockchain.blocks[0].valid?).to eq(true)
      expect(blockchain.blocks[1].valid?).to eq(true)
    end

    it 'should save prev block' do
      expect(blockchain.blocks[1].prev).to_not be_nil
      expect(blockchain.blocks[1].prev).to eq(blockchain.blocks[0].hash)
    end

    describe 'block.valid? when prev block is invalid' do
      before(:each) do
        blockchain.blocks.each{|block| block.mining}
        genesis = blockchain.blocks[0]
        genesis.data = 'Changed'
      end

      it 'blocks are unvalidated' do
        expect(blockchain.blocks[0].valid?).to eq(false)
        expect(blockchain.blocks[1].valid?).to eq(false)
      end 

      it 'should have last_block' do
        expect(blockchain.blocks[0].last_block).to eq(nil)
        expect(blockchain.blocks[1].last_block).to_not eq(nil)
      end

      context 'when blocks are mining' do
        before do
          blockchain.blocks[0].mining
          blockchain.blocks[1].mining
        end
        it 'when mining all bocks' do
          expect(blockchain.blocks[0].valid?).to eq(true)
          expect(blockchain.blocks[1].valid?).to eq(true)
        end
      end

    end

    it 'should assign blockchain to block' do
      expect(blockchain.blocks[1].blockchain).to_not eq(nil)
    end
  end
end
