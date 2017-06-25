require 'eventmachine'
require 'uri'

module SimpleBlockchain
  class Connection < EM::Connection
    def initialize(*args)
      super
      @parser = Protocol::Pkt::Parser.new(self)
    end

    def self.broadcast(command,payload)
      self.peers(ENV['PEERS']).each do |socket|
        socket.write(Protocol::Pkt.build("new_block",payload))
      end
    end

    def self.peers(node_addreses=nil)
      return @peers if @peers
      return @peers || [] unless node_addreses
      node_addreses.split(',').map{|uri| URI('tcp://' + uri) }.map do |uri|
        begin
          Socket.tcp(uri.hostname,uri.port)
        rescue => err
          Logger.info("cannot create connection with #{uri.inspect} : #{err.inspect}")
          nil
        end
      end.compact
    end

    def post_init
      puts "-- someone connected to the echo server!"
    end

    def on_new_block(block)
      Block.new(block)
    end

    def on_ping(payload)
      send_data Protocol::Pkt.pong(payload)
    end

    def receive_data data
      begin
        parsed = @parser.process_pkt(data)
        puts parsed.inspect
      rescue => err
        puts data
        puts "Malformed msgpack message or no recognized command #{err.inspect}"
        send_data "error"
      end
    end
  end
end
