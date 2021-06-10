class BunnyConfiguration
  def initialize
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel
    @exchange = @channel.default_exchange
    @push_queue = @channel.queue("payment_requests.create", :durable => true)
    @pop_queue = @channel.queue("payment_requests.update", :durable => true)

    @push_queue.subscribe do |delivery_info, metadata, payload|
      PaymentRequest.new(JSON.parse(payload)).save!
    end
  end

  def publish(payload)
    @exchange.publish(payload, :routing_key => "payment_requests.update")
  end
end

BUNNY_OBJECT = BunnyConfiguration.new
