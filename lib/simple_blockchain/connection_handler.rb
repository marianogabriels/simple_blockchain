require 'eventmachine'
require 'uri'

module SimpleBlockchain
  class Connection < EM::Connection
    def initialize(*args)
      super
      @parser = Protocol::Pkt::Parser.new(self)
    end

    def self.peers
      ENV['PEERS'].split(',').map{|uri| URI(uri).port == nil ? URI('tcp://' + uri) : URI(uri) }
    end

    def post_init
      puts "-- someone connected to the echo server!"
    end

    def on_ping(payload)
      send_data Protocol::Pkt.pong(payload)
    end

    def on_new_block
    end

    def receive_data data
      begin
        parsed = @parser.process_pkt(data)
        puts parsed.inspect
      rescue MessagePack::MalformedFormatError
        puts data
        puts "Malformed msgpack message"
      end
    end
  end
end
