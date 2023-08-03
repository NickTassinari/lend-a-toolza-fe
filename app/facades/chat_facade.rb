class ChatFacade 
  def self.chat_request(project)
    ChatApiService.chat_request(project)
  end
end