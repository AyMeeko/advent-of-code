# frozen_string_literal: true

require 'pry'
require 'spec_helper'

def input_file
  File.readlines("#{__dir__}/input.txt")
end

def calculate
  4
end

def solve
  4
end

puts "The answer is #{solve}."

RSpec.describe "#{File.basename(__dir__)} examples" do
  [
    [12, 2]
  ].each do |input, output|
    it "calculates an input of #{input} results in #{output} output" do
      expect(calculate(input)).to equal(output)
    end
  end
end
