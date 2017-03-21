require "spec_helper"

describe SimpleBlockchain do
  it "has a version number" do
    expect(SimpleBlockchain::VERSION).not_to be nil
  end
end

describe Block do
  describe 'initialize' do
    let!(:block){Block.new(index: 1,prev: 0,timestamp: 1489908099,data: "genesis")}
    it '#index' do
      expect(block.index).to eq(1)
    end
    it '#prev' do
      expect(block.prev).to eq(0)
    end
    it '#timestamp' do
      expect(block.timestamp).to eq(1489908099)
    end

    it '#data' do 
      expect(block.data).to eq("genesis")
    end

    it '#mining' do
      block.mining
      puts block.nonce
      expect(block.valid_hash?).to eq(true)
    end

    it '#valid_hash?' do
      expect(block.valid_hash?).to eq(false)
      block.mining
      expect(block.valid_hash?).to eq(true)
    end
  end
end
