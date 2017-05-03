class AsyncWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: 'test_queue'

  def perform(node_data)
    print "Perform started\n"
    do_perform(node_data)
    print "Perform finished\n"
  end

  private
  def do_perform(node_data)
    node = deserialize_node(node_data)
    Instrument.instrument('work', { node: node }) do
      print "Doing work!\n"
    end
  end

  def deserialize_node(node_data)
    node_class = node_data['node_class']
    node_class.constantize.find(node_data['node_id'])
  rescue => e
    print "Error deserializing node\n"
    raise e
  end
end