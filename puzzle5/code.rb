# frozen_string_literal: true

require 'debug'
require 'spec_helper'

def input_file(file_name)
  File.readlines("#{__dir__}/#{file_name}")
end

def identify_new_range(letter, range)
  midway_point = (range.to_a.length / 2)

  new_range_array = range.first(midway_point) if %w[F L].include?(letter)
  new_range_array = range.last(midway_point) if %w[B R].include?(letter)
  (new_range_array[0]..new_range_array[-1])
end

def translate_boarding_pass(boarding_pass, range = (0..127), row = nil)
  boarding_pass = boarding_pass.strip

  if range.first == range.last
    if row.nil?
      row = range.first
      return translate_boarding_pass(boarding_pass, (0..7), row)
    else
      column = range.first
      seat_id = row * 8 + column
      return [row, column, seat_id]
    end
  end

  new_range = identify_new_range(boarding_pass[0], range)
  translate_boarding_pass(boarding_pass[1..], new_range, row)
end

def part1
  highest_seat_id = 0
  boarding_passes = input_file('input.txt')
  boarding_passes.each do |boarding_pass|
    _, _, seat_id = translate_boarding_pass(boarding_pass)
    highest_seat_id = seat_id if seat_id > highest_seat_id
  end
  highest_seat_id
end

def part2
  boarding_passes = input_file('input.txt')
  seat_ids = []
  boarding_passes.each do |boarding_pass|
    _, _, seat_id = translate_boarding_pass(boarding_pass.strip)
    seat_ids << seat_id
  end
  my_seat = 0
  seat_ids.sort.each_with_index do |seat_id, index|
    seat_mate = seat_ids[index + 1]
    my_seat = seat_id + 1 if seat_mate && (seat_mate - seat_id) >= 2
  end
  my_seat
end

puts "The answer to part1 is #{part1}."
puts "The answer to part2 is #{part2}."

RSpec.describe "#{File.basename(__dir__)} examples" do
  context 'solving the example' do
    [
      ['F', (0..127), (0..63)],
      ['B', (0..63), (32..63)],
      ['F', (32..63), (32..47)],
      ['B', (32..47), (40..47)],
      ['B', (40..47), (44..47)],
      ['F', (44..47), (44..45)],
      ['F', (44..45), (44..44)]
    ].each do |letter, input_range, new_range|
      it "processing #{letter} results in #{new_range}" do
        expect(identify_new_range(letter, input_range)).to eq(new_range)
      end
    end
  end

  [
    ["FBFBBFFRLR\n", 44, 5, 357],
    ["BFFFBBFRRR\n", 70, 7, 567],
    ["FFFBBBFRRR\n", 14, 7, 119],
    ["BBFFBBFRLL\n", 102, 4, 820]
  ].each do |boarding_pass, row, column, seat_id|
    it "determines #{boarding_pass.strip} is row #{row}, column #{column} and seat ID #{seat_id}" do
      actual_row, actual_column, actual_seat_id = translate_boarding_pass(boarding_pass)

      expect(actual_row).to eq(row)
      expect(actual_column).to eq(column)
      expect(actual_seat_id).to eq(seat_id)
    end
  end
end
