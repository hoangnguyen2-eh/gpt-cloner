class MyNewTopicConsumer < Karafka::BaseConsumer
    def consume
        params_batch.each do |message|
            # Process each message
            puts "Received message: #{message}"
        end
    end
end
