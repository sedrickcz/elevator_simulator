
#elevator_spec.rb

require '../elevator'

RSpec.describe Elevator, type: :model do

  it "raises exception if wrong argument" do
    expect { Elevator.new("a", "vb") }.to  raise_error(ArgumentError, "Argument is not valid")
  end

  let(:elevator) { Elevator.new(-2, 15) }

  it "can move to floor" do
    elevator.insert_floor_number(5)
    elevator.move
    expect(elevator.current_floor).to eq(5)
  end

  it "can mantain list of floor numbers in right order" do
    elevator.insert_floor_number(5)
    elevator.insert_floor_number(0)
    elevator.insert_floor_number(7)
    expect(elevator.up_list.first).to eq(7)
    expect(elevator.up_list[1]).to eq(5)
    expect(elevator.up_list.last).to eq(0)
  end

  it "moves from down to up and down" do
    elevator.insert_floor_number(5)
    elevator.insert_floor_number(0)
    elevator.move
    expect(elevator.current_floor).to eq(0)
    elevator.insert_floor_number(-2)
    elevator.move
    expect(elevator.current_floor).to eq(5)
    elevator.move
    expect(elevator.current_floor).to eq(-2)
  end

  it "accept correct floor number" do
    expect(elevator.insert_floor_number(5)).to eq(true)
  end

  it "reject incorrect floor number" do
    expect(elevator.insert_floor_number(25)).to eq(false)
  end

  it "shows floor number in list" do
    elevator.insert_floor_number(7)
    expect(elevator.up_list.include?(7)).to eq(true)
  end

  it "shows floor number in correct list" do
    elevator.insert_floor_number(7)
    expect(elevator.up_list.include?(7)).to eq(true)
    expect(elevator.down_list.include?(7)).to eq(false)
  end

  it "shows next stop" do
    elevator.insert_floor_number(1)
    elevator.insert_floor_number(0)
    elevator.move
    expect(elevator.next_stop).to eq(1)
  end
end
