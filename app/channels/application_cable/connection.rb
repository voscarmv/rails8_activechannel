module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      set_current_user || reject_unauthorized_connection
    end

    private
    def set_current_user
      # puts request.params.inspect
      # puts request.headers.inspect
      # if session = Session.find_by(token: request.headers['Sec-WebSocket-Protocol']&.split(",")[-1])
      if session = Session.find_by(token: request.params[:token])
        self.current_user = session.user
      end
    end
  end
end
