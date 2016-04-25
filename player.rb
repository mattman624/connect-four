
class Player
  attr_accessor :name, :mark

  def initialize(name, mark)
    @name = name.capitalize
    @mark = mark
  end

end
