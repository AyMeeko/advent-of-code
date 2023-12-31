# frozen_string_literal: true

require 'debug'
require 'spec_helper'

def input_file(file_name)
  File.readlines("#{__dir__}/#{file_name}")
end

def part1(file_name)
  group_list = input_file(file_name)
  group_list = group_list.join.split("\n\n").map do |p|
    p = p.split('').uniq.join
    p = p.gsub("\n", '')
    p.length
  end
  group_list.inject(:+)
end

def part2(file_name)
  group_list = input_file(file_name)
  group_list = group_list.join.split("\n\n")
  sum = 0
  group_list.each do |group|
    number_of_people = group.strip.scan(/\n/).length + 1
    group_sum = 0
    'abcdefghijklmnopqrstuvwxyz'.each_char do |letter|
      group_sum += 1 if group.scan(/#{letter}/).length == number_of_people
    end
    sum += group_sum
  end

  sum
end

puts "The answer to part1 is #{part1('input.txt')}."
puts "The answer to part2 is #{part2('input.txt')}."

RSpec.describe "#{File.basename(__dir__)} examples" do
  it 'part1: determines the example groups sum to 11' do
    expect(part1('example.txt')).to eq(11)
  end

  it 'part2: determines the example groups sum to 6' do
    expect(part2('example.txt')).to eq(6)
  end
end
