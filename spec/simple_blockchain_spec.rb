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
      expect(block.valid_hash?(block.hash)).to eq(true)
    end

    it '#valid_hash?' do
      block.mining
      expect(block.valid_hash?("0000242208512629a13fad6d63ceeaeb9cee37f950b9f1f41d4a2713fbb0778b")).to eq(false)
      expect(block.valid_hash?("0130242208512629a13fad6d63ceeaeb9cee37f950b9f1f41d4a2713fbb0778b")).to eq(false)
      expect(block.valid_hash?("096b46474f82507f65b7fe6d390431a2f8fe1fb8180b56b3cb4bf31ef3c11f29")).to eq(true)
    end
  end
end
