# frozen_string_literal: true

require 'debug'
require 'spec_helper'

def input_file(file_name)
  File.readlines("#{__dir__}/#{file_name}")
end

def part1(file_name)
  4
end

def part2(file_name)
  4
end

# puts "The answer to part1 is #{part1('input.txt')}."
# puts "The answer to part2 is #{part2('input.txt')}."

RSpec.describe "#{File.basename(__dir__)} examples" do
  it 'determines 2 passwords are valid' do
    expect(part1('example.txt')).to eq('')
  end
end
