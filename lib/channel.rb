# To change this template, choose Tools | Templates
# and open the template in the editor.

class Channel
  @@list = []

  def initialize(id)
    @id = id
    @user_list = []
  end

  def self.add(channel)
    @@list << channel
  end

  # Creates a new channel within the application
  def self.create(id)
    channel = Channel.new(id)
    Channel.add(channel)
  end

  def self.list
    @@list
  end

  def self.find(id)
    @@list.detect { |channel| channel.id == id }
  end

  attr_accessor :id, :user_list
end
