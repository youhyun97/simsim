class ChatController < ApplicationController
  def index
  end


  def name
    @name = params[:name]
  end

  def new
    @ask = params[:ask]
  end
  
  def create
    Chat.create(is_man: true, content: params[:content])
    dic = Dictionary.where(ask: params[:content]).sample
    if dic.nil?
      redirect_to "/chat/new?ask=#{URI.encode(params[:content])}"
    else
      Chat.create(is_man: false, content: dic.answer)
      # render text: params[:content]
      redirect_to '/chat/index'
    end  
  end
  
  def destroy
    @delete = Chat.find(params[:id])
    @delete.destroy
    
    redirect_to '/chat/index'
  end
  
  def learn
    Dictionary.create(ask: params[:ask], answer: params[:answer])
    # render text: params[:ask]
    redirect_to '/chat/index'
  end
end
