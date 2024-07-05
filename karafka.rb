require 'karafka'

class KarafkaApp < Karafka::App
    setup do |config|
      config.client_id = 'my_application'
      # librdkafka configuration options need to be set as symbol values
      config.kafka = {
        'bootstrap.servers': '127.0.0.1:9092'
      }
    end
    consumer_groups.draw do
        consumer_group 'myNewTopicConsumer' do
          topic 'myNewTopic' do
            consumer MyNewTopicConsumer
          end
        end
    end
end