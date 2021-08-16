# frozen_string_literal: true

require 'pry'
require 'spec_helper'

def input_file(file_name)
  File.readlines("#{__dir__}/#{file_name}")
end

def part1(file_name, right, down)
  ##
  ##        ..##.......
  ##        #...#...#..
  ##        .#....#..#.
  ##        ..#.#...#.#
  ##        .#...##..#.
  ##        ..#.##.....
  ##        .#.#.#....#
  ##        .#........#
  ##        #.##...#...
  ##        #...##....#
  ##        .#..#...#.#
  ##

  map = input_file(file_name).map(&:strip)
  map_width = map[0].length
  coordinate_x = 0
  coordinate_y = 0
  trees = 0

  map.length.times do
    # puts "coordinates: #{coordinate_x}, #{coordinate_y}"
    trees += 1 if map[coordinate_y][coordinate_x] == '#'
    # puts "trees: #{trees}"

    coordinate_y += down
    coordinate_x += right
    coordinate_x -= map_width if coordinate_x >= map_width
  end
  trees
end

def part2(file_name, right, down)
  map = input_file(file_name).map(&:strip)
  map_width = map[0].length
  coordinate_x = 0
  coordinate_y = 0
  trees = 0

  (map.length.to_f / down).ceil.times do
    trees += 1 if map[coordinate_y][coordinate_x] == '#'

    coordinate_y += down
    coordinate_x += right
    coordinate_x -= map_width if coordinate_x >= map_width
  end
  trees
end

puts "The answer to part1 is #{part1('input.txt', 3, 1)}."
answer = [
  part2('input.txt', 1, 1),
  part2('input.txt', 3, 1),
  part2('input.txt', 5, 1),
  part2('input.txt', 7, 1),
  part2('input.txt', 1, 2)
].inject(:*)
puts "The answer to part2 is #{answer}."

RSpec.describe "#{File.basename(__dir__)} examples" do
  it "determines we'd encounter 7 trees" do
    expect(part1('example.txt', 3, 1)).to eq(7)
  end

  it 'verifies the example for part2' do
    answer = [
      part2('example.txt', 1, 1),
      part2('example.txt', 3, 1),
      part2('example.txt', 5, 1),
      part2('example.txt', 7, 1),
      part2('example.txt', 1, 2)
    ].inject(:*)
    expect(answer).to eq(336)
  end
end
