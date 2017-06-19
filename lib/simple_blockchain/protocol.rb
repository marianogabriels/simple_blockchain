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

    class Parser
      attr_accessor :handler
      def initialize(handler)
        @handler = handler
      end

      def process_pkt(pkt)
        unpacked_pkt = MessagePack.unpack(pkt)
        command = unpacked_pkt['command']
        puts unpacked_pkt.inspect
        case command
        when 'ping'; @handler.on_ping(unpacked_pkt['payload'])
        when 'pong'; @handler.on_pong(unpacked_pkt['payload'])
        when 'new_block'; @handler.on_new_block(unpacked_pkt['payload'])
        else
          raise "Error unknown command #{command.inspect}"
        end
      end
    end
  end
end
