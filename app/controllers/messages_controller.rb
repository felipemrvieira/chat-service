class MessagesController < ApplicationController
    def create
        message = Message.new(message_params)
        if message.save
            conversation = Conversation.find(message.conversation_id)
            ConversationChannel.broadcast_to(conversation, message)
            # render json: message
        else
            render json: {errors: message.errors.full_messages}, status: 422
        end
    end
   
    private
    def message_params
        params.require(:message).permit(:content, :conversation_id)
   end
end
