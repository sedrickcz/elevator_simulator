#elevator.rb
class Elevator
  attr_reader :floors_range, :current_floor, :up_list, :down_list, :direction, :active_list, :next_stop

  def initialize(min = 1, max = 10)
    raise ArgumentError, 'Argument is not valid' if !_valid?(min,max)

    @floors_range = Range.new(min.to_i, max.to_i)
    @up_list = []
    @down_list = []
    @current_floor = @floors_range.begin
    @direction = :up
    @active_list = nil
  end

  def insert_floor_number(floor_number)
    if _is_correct_floor_number?(floor_number)
      return _insert_number!(floor_number).include?(floor_number)
    end
    false
  end

  def move
    _prepare
    if active_list
      if direction == :up
        ((current_floor + 1).upto(_last_stop(active_list))).each do |floor|
          _move_to_floor(floor, active_list)
          break if _should_stop?(floor, active_list)
        end
      else
        ((current_floor - 1).downto(_last_stop(active_list))).each do |floor|
          _move_to_floor(floor, active_list)
          break if _should_stop?(floor, active_list)
        end
      end
    end
    false
  end

  def next_stop
    active_list ? active_list.last : ""
  end

  def _move_to_floor(floor, active_list)
    @current_floor = floor
    sleep(1)
    puts "Floor ##{floor}"
  end

  def _should_stop?(floor, active_list)
    if active_list.last == floor
      active_list.pop
      return true
    end
    false
  end

  def _valid?(min_floor, max_floor)
    _is_numeric?(min_floor) && _is_numeric?(max_floor) && _must_be_in_right_order(min_floor,max_floor)
  end

  def _prepare
    unless up_list.empty?
      @direction = :up
      @active_list = up_list
      return true
    end
    unless down_list.empty?
      @direction = :down
      @active_list = down_list
      return true
    end
    @active_list = nil
    false
  end

  def _last_stop(list)
    list.first
  end


  def _is_correct_floor_number?(number)
    _is_in_floor_range?(number) && _is_not_current_floor?(number)
  end

  def _is_in_floor_range?(number)
    floors_range === number
  end

  def _is_not_current_floor?(number)
    number != current_floor
  end

  def _up?(number)
    number - current_floor > 0
  end

  def _insert_number!(number)
    if _up?(number)
      _insert_to_list(number, up_list)
      up_list.sort! { |x,y| y <=> x }.uniq!
      up_list
    else
      _insert_to_list(number, down_list)
      down_list.sort!.uniq!
      down_list
    end
  end

  def _insert_to_list(number, list)
    list << number
  end

  def _is_numeric?(input)
    Float(input) != nil rescue false
  end

  def _must_be_in_right_order(min_floor, max_floor)
    min_floor < max_floor
  end
end
