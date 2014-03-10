module EventsHelper

  def my_event?(event)
    event.session_id == request.session_options[:id]
  end

end
