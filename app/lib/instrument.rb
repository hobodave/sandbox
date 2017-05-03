module Instrument
  def self.instrument(event_name, *args)
    t0 = Time.now
    log({ event_name: event_name, state: :started, args: args })
    result = yield
    log({ event_name: event_name, state: :succeeded, args: args, duration: Time.now - t0 })
    return result
  rescue Exception => error
    handle_exception(event_name, error, t0, args)
    raise error
  end

  def self.handle_exception(event_name, error, t0, args)
    log({ event_name: event_name, state: :errored, args: args, duration: Time.now - t0 }, error)
  rescue Exception => error
    log({ event_name: event_name, state: :error_logging_error }, error)
    raise error
  end

  def self.log(data, exception = nil)
    log_line = {
      time: Time.now,
      data: data,
      level: 'info',
    }

    if exception
      log_line[:data].merge!({
        exception: {
          type: exception.class.to_s,
          message: exception.message,
          backtrace: exception.backtrace.to_a
        }
      })
    end

    print "#{log_line.to_json}\n"
  end
end