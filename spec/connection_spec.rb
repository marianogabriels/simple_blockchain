require 'spec_helper' 

describe SimpleBlockchain::Connection do
  describe '.peers' do
    it "when socket addrs doesn't exists" do
      expect(SimpleBlockchain::Connection.peers('localhost:3000,app.example.com:5000')).to be_a(Array)
      expect(SimpleBlockchain::Connection.peers('localhost:3000,app.example.com:5000').length).to eq(0)
    end

    it "when socket addrs exists" do
      TCPServer.new("127.0.0.1", 3399)
      expect(SimpleBlockchain::Connection.peers('localhost:3399,app.example.com:5000')).to be_a(Array)
      expect(SimpleBlockchain::Connection.peers('localhost:3399,app.example.com:5000').count).to eq(1)
    end
  end
end
