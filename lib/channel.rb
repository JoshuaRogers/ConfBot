# To change this template, choose Tools | Templates
# and open the template in the editor.

class Channel

  def initialize(id, connection)
    @id = id
    @connection = connection
    @user_list = []
  end

  def add_user(user)
    @user_list << user unless @user_list.index(user)
  end

  def delete_user(user)
    @user_list.delete(user)
  end

  attr_accessor :connection, :id, :user_list
end
