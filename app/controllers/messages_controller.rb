class MessagesController < ApplicationController
  def index
    flash.now[:new] = 'チャットグループが作成されました。'
  end
end
