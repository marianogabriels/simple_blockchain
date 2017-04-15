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
