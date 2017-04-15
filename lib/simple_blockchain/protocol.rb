require 'msgpack'
module Protocol
  SB_VERSION = '1'
  MAGICK = 'SimpleBlockchain'

  def self.pkt(command,payload=nil)
    Pkt.build(command,payload=nil)
  end

  class Pkt
    def self.build(command,payload=nil)
      {
        version: Protocol::SB_VERSION,
        magick: Protocol::MAGICK,
        command: command,
        payload: payload
      }.to_msgpack
    end

    def self.ping(nonce=rand(0xffffffff))
      build("ping",nonce)
    end

    def self.pong(nonce)
      build("pong",nonce)
    end
  end
end
