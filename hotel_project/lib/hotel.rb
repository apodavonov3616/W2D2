require_relative "room"

class Hotel
  def initialize(name, rooms_and_capacity_hash)
    @name = name
    @rooms = {}
    rooms_and_capacity_hash.each do |room_name, capacity|
      @rooms[room_name] = Room.new(capacity)
    end
  end

  def name
    words = @name.split(' ')
    words.map!(&:capitalize)
    words.join(' ')
  end

  def rooms
    @rooms
  end

  def room_exists?(name)
    @rooms.has_key?(name)
  end

  def check_in(person, room_name)
    if self.room_exists?(room_name)
      variable = @rooms[room_name].add_occupant(person)
      if variable
        print 'check in successful'
      else
        print 'sorry, room is full'
      end
    else
      print 'sorry, room does not exist'
    end
  end

  def has_vacancy?
    !@rooms.all? { |name, room| room.full? }
  end

  def list_rooms
    @rooms.each do |name, room_object|
      puts name.to_s + " : " + room_object.available_space.to_s
    end
  end
end
