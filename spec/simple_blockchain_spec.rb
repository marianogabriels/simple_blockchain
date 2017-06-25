require "spec_helper"

describe SimpleBlockchain do
  it "has a version number" do
    expect(SimpleBlockchain::VERSION).not_to be nil
  end
end

describe Block do
  describe 'initialize' do
    let!(:blockchain){ Blockchain.new(no_genesis: true) }
    let!(:block){Block.new(prev: 0,timestamp: 1489908099,data: "genesis",blockchain: blockchain)}

    it '#index' do
      expect(block.index).to eq(0)
    end

    it '#prev of genesis block should be nil',focus: true do
      expect(block.prev).to eq(nil)
    end

    it '#timestamp' do
      expect(block.timestamp).to eq(1489908099)
    end

    it '#data' do 
      expect(block.data).to eq("genesis")
    end

    it '#mining' do
      block.mining
      expect(block.valid_hash?).to eq(true)
    end

    it '#valid_hash?' do
      expect(block.valid_hash?).to eq(false)
      block.mining
      expect(block.valid_hash?).to eq(true)
    end
  end
end
