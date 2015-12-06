#!/usr/bin/env ruby -wKU

# Require dependencies
require './elevator.rb'

class ElevatorService
  attr_reader :elevator

  def initialize
    puts "..:: ELEVATOR SIMULATOR ::.."

    print "Insert minimal floor number: "
    min_floor = STDIN.gets.chomp()

    print "Insert maximal floor number: "
    max_floor = STDIN.gets.chomp()

    # Init elevator
    @elevator = Elevator.new(min_floor, max_floor)

    run
  end

  def elevator_info
    puts ""
    puts "*******************************************"
    puts "ELEVATOR INFO"
    puts "*******************************************"
    puts "Current floor: #{elevator.current_floor}"
    puts "Current direction: #{elevator.direction}"
    puts "Next stop: #{elevator.next_stop}"
    puts "Up List: #{elevator.up_list}"
    puts "Down List: #{elevator.down_list}"
    puts "*******************************************"
  end

  def run
    loop do
      break unless elevator.move
    end
    elevator_info
    floor_insertion
    run
  end

  def floor_insertion
    loop do
      break if !insert
    end
  end

  def insert
    puts ""
    print "Insert desired floor number or leave it empty to go: "
    input = STDIN.gets.chomp()
    if input == ""
      false
    else
      floor_number = input.to_i

      unless elevator.insert_floor_number(floor_number)
        puts "Error: You have inserted incorrect floor number!"
      end
      true
    end
  end
end

ElevatorService.new
