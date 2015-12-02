class Player
  
  attr_reader :name, :sets

  def initialize(name = "Player1", sets = [])
    @name = name
    @sets = sets
  end

  def add_set(set)
    puts "\nSet #{set_capture_message(set)} captured by #{@name}!"
    @sets << set
  end
  
  def set_capture_message(set)
    "[#{set.map(&:to_s).join(", ")}]"
  end
  
  def sets_captured_message
    msg = "#{name}'s Sets (#{@sets.count} Total):\n"
    @sets.each_with_index do |s, i| 
      msg += "#{set_capture_message(s)} \n"
    end
    
    msg
  end
  
  def display_score
    puts "#{@name} Sets: #{@sets.count}"
  end

  def <=>(other_player)
    sets.count <=> other_player.sets.count
  end
end
