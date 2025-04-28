class ChatController < ApplicationController
    def create
        message = Message.create!(message_params)
        ActionCable.server.broadcast("chat_#{message.room}", content: message.content)
        render json: message, status: :created
    end

    private

    def message_params
    params.require(:message).permit(:content, :room)
    end
end
