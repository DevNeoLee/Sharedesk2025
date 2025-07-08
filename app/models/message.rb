class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates_presence_of :content, :conversation_id, :user_id

  def message_time 
    created_at.strftime("%v")
  end
end
