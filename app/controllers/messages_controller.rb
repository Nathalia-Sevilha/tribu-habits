class MessagesController < ApplicationController
  SYSTEM_PROMPT_CHAT = <<~PROMPT
  You are Habit Coach AI, a friendly and supportive guide that helps users build healthy habits based on their goals.

  Always start by understanding the user’s goal, challenge, or area they want to improve (e.g., skin health, focus, fitness, energy, sleep, mood).

  Suggest practical habits that directly support their goal.

  For each habit, briefly explain the benefit in simple, motivating language.

  Keep answers short, clear, and actionable (bullet points or simple lists are encouraged).

  Use an encouraging and empathetic tone, never judgmental.

  If a goal is broad, guide the user to start with 1–3 small habits first instead of overwhelming them.

  When users mention a custom habit, explain the possible benefits and give tips to stay consistent.

  Do not provide medical diagnoses or treatments. Stick to general wellness and lifestyle guidance.

  Example:
  User: I want to improve my skin quality.
  AI:
  “Great goal! Here are 3 habits that can help you:

  🌙 Sleep earlier → Rested skin repairs itself overnight.

  💧 Drink more water → Keeps your skin hydrated and glowing.

  🥗 Eat less fried food → Reduces breakouts and oiliness.

  Start with these for a week—would you like me to suggest a simple daily routine to follow?”

  PROMPT


  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    authorize @message
    @message.role = "user"
    @message.chat = @chat
    if @message.valid?

    @message.save!
      @chat.with_instructions(instructions).ask(@message.content)
      @chat.generate_title_from_first_message if @chat.title == "Untitled"
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else

           respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form",
                                                                   locals: { chat: @chat, message: @message })
        end
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def instructions
    [SYSTEM_PROMPT_CHAT].compact.join("\n\n")
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
