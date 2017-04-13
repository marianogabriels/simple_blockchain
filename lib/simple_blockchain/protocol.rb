require 'msgpack'
module Protocol
  SB_VERSION = '1'
  MAGICK = 'SB'
  def self.pkt(command, payload=nil)
    {
      version: SB_VERSION,
      magick: MAGICK
    }.to_msgpack
  end
end
