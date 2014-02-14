require 'trello'
require 'dotenv'

include Trello

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_KEY']
  config.member_token = ENV['TRELLO_TOKEN']
end

SCHEDULER.every '5m', :first_in => 0 do |job|
  board = Board.find(ENV['TRELLO_BOARD_ID'])
  cards = board.lists[0].cards
  names = cards.map { |card| { label: card.name } }
  if cards.length > 0
    send_event('trello', { :items => names, :title => "Big Rocks" })
  else
    send_event('trello', { :title => "No More Big Rocks!" })
  end
end
