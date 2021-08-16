# frozen_string_literal: true

require 'pry'
require 'spec_helper'

def input_file(file_name)
  File.readlines("#{__dir__}/#{file_name}")
end

def part1(file_name)
  entries = input_file(file_name)
  entries.each do |entry1|
    entry1 = entry1.to_i
    entries.each do |entry2|
      entry2 = entry2.to_i
      return entry1 * entry2 if (entry1 + entry2) == 2020
    end
  end
end

def part2(file_name)
  entries = input_file(file_name)
  entries.each do |entry1|
    entry1 = entry1.to_i
    entries.each do |entry2|
      entry2 = entry2.to_i
      entries.each do |entry3|
        entry3 = entry3.to_i
        return entry1 * entry2 * entry3 if (entry1 + entry2 + entry3) == 2020
      end
    end
  end
end

puts "The answer to part1 is #{part1('input.txt')}"
puts "The answer to part2 is #{part2('input.txt')}"

RSpec.describe "#{File.basename(__dir__)} examples" do
  it 'calculates the product of the two numbers that sum to 2020' do
    expect(part1('example.txt')).to eq(514_579)
  end

  it 'calculates the product of the three numbers that sum to 2020' do
    expect(part2('example.txt')).to eq(241_861_950)
  end
end
