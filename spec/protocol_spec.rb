require 'spec_helper'

def unpack(pkt)
  MessagePack.unpack(pkt)
end
describe Protocol::Pkt do
  it 'magick should be SimpleBlockchain' do
    expect(unpack(described_class.build('ping'))['magick']).
      to eq('SimpleBlockchain')
  end

  it '.ping' do
    expect(unpack(described_class.ping)['payload']).to be_truthy
  end

  it '.pong' do
    expect(unpack(described_class.pong('hola'))['payload']).to eq('hola')
  end
end

describe 'Protocol::Parser (ping/pong)' do
  class PingHandler
    attr_reader :nonce
    def on_ping(nonce)
      @nonce = nonce
      return "ping #{nonce}" 
    end

    def on_pong(nonce)
      @nonce = nonce
      return "pong #{nonce}"
    end
  end
  let!(:parser){ Protocol::Pkt::Parser.new(PingHandler.new) }
  it { expect(parser.handler.nonce).to eq(nil) }

  it { expect(parser.process_pkt(Protocol::Pkt.ping)).to match("ping") }
  it do 
    expect(parser.process_pkt(Protocol::Pkt.pong('hola'))).to match("pong hola")
    expect(parser.handler.nonce).to_not eq(nil)
  end
end

describe 'Connection' do
  it 'should assign peers' do
    ENV['PEERS'] = 'app.example.com:3000'
    expect(SimpleBlockchain::Connection.peers[0].port).to eq(3000)
    ENV['PEERS'] = 'tcp://app.example.com:3000,localhost:3012'
    expect(SimpleBlockchain::Connection.peers.count).to eq(2)
  end
end
