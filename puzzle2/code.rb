# frozen_string_literal: true

require 'pry'
require 'spec_helper'

def input_file(file_name)
  File.readlines("#{__dir__}/#{file_name}")
end

def part1(file_name)
  policies = input_file(file_name)

  valid_passwords = 0
  policies.each do |policy|
    range, policy_letter, password = policy.split(' ')
    minimum, maximum = range.split('-').map(&:to_i)
    policy_letter = policy_letter[0]

    p = password.gsub(/[^#{policy_letter}]/, '').length
    valid_passwords += 1 if p <= maximum && p >= minimum
  end

  valid_passwords
end

def part2(file_name)
  policies = input_file(file_name)

  valid_passwords = 0
  policies.each do |policy|
    range, policy_letter, password = policy.split(' ')
    minimum, maximum = range.split('-').map(&:to_i)
    policy_letter = policy_letter[0]

    position_one = password[minimum - 1] == policy_letter
    position_two = password[maximum - 1] == policy_letter

    valid_passwords += 1 if position_one ^ position_two
  end

  valid_passwords
end

puts "The answer to part1 is #{part1('input.txt')}."
puts "The answer to part2 is #{part2('input.txt')}."

RSpec.describe "#{File.basename(__dir__)} examples" do
  it 'determines 2 passwords are valid' do
    expect(part1('example.txt')).to equal(2)
  end

  it 'determines 1 passwords is valid' do
    expect(part2('example.txt')).to equal(1)
  end
end
