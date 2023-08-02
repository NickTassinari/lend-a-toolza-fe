class ChatFacade 
  def self.chat_request(project)
    ChatService.chat_request(project)
    # ChatService.chat_request(project)[:choices][0][:text]
  end
end