class ConversationsController < ApplicationController

    def index
        conversations = Conversation.all
        render json: conversations
    end

    def create
        conversation = Conversation.new(conversation_params)
        if conversation.save
            render json: conversation
        else
            render json: {errors: conversation.errors.full_messages}, status: 422
        end
    end

    def show
        conversation = Conversation.find(params[:id])
        render json: conversation, include: [:messages]
   end

   private
   def conversation_params
        params.require(:conversation).permit(:name)
   end
end
