class ChatsController < ApplicationController

  def new
    @chat = Chat.new
    authorize @chat
  end

  def create
    @chat = Chat.new(title: "Untitled", model_id: "gpt-4o-mini")
    authorize @chat
    @chat.user = current_user
    if @chat.save
      MessagesController.new.welcome_message(@chat)
      redirect_to chat_path(@chat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @chat = Chat.includes(:messages).find(params[:id])
    authorize @chat
    @message = Message.new
  end
end
