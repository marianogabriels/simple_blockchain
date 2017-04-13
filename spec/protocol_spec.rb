require 'spec_helper'

describe Protocol do
  it do
    expect(MessagePack.unpack(Protocol.pkt('ping'))['magick']).to eq('SB')
  end
end


