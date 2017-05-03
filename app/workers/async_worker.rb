class AsyncWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: 'test_queue'

  def perform(node_data)
    logger.info "Perform started"
    do_perform(node_data)
    logger.info "Perform finished\n"
  end

  private
  def do_perform(node_data)
    node = deserialize_node(node_data)
    Instrument.instrument('work', { node: node }) do
      logger.info "Doing work!\n"
    end
  end

  def deserialize_node(node_data)
    Node.find(node_data['node_id'])
  rescue => e
    logger.info "Error finding node\n"
    raise e
  end
end