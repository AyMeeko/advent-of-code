# frozen_string_literal: true

require 'pry'
require 'spec_helper'

def input_file(file_name)
  File.readlines("#{__dir__}/#{file_name}")
end

class Passport
  attr_reader :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid
  attr_accessor :cid

  def valid?
    byr && iyr && eyr && hgt && hcl && ecl && pid
  end

  def byr=(value)
    value = value.to_i
    return unless value.to_s.length == 4 && value >= 1920 && value <= 2002

    @byr = value
  end

  def iyr=(value)
    value = value.to_i
    return unless value.to_s.length == 4 && value >= 2010 && value <= 2020

    @iyr = value
  end

  def eyr=(value)
    value = value.to_i
    return unless value.to_s.length == 4 && value >= 2020 && value <= 2030

    @eyr = value
  end

  def hgt=(value)
    number = value[0..-3].to_i

    if value.include?('cm')
      return unless number >= 150 && number <= 193
    elsif value.include?('in')
      return unless number >= 59 && number <= 76
    else
      return
    end

    @hgt = value
  end

  def hcl=(value)
    return unless value.match(/#[0-9a-f]{6}/) && value.length == 7

    @hcl = value
  end

  def ecl=(value)
    return unless %w[amb blu brn gry grn hzl oth].include?(value)

    @ecl = value
  end

  def pid=(value)
    return unless value.match(/[0-9]{9}/) && value.length == 9

    @pid = value
  end
end

def part1(file_name)
  passport_list = input_file(file_name)
  passport_list = passport_list.join.split("\n\n").map { |p| p.gsub("\n", ' ') }

  valid_passports = 0
  passport_list.each do |raw_passport_data|
    passport = Passport.new
    raw_passport_data.split(' ').each do |attr|
      property, value = attr.split(':')
      passport.send("#{property}=", value)
    end
    valid_passports += 1 if passport.valid?
  end
  valid_passports
end

puts "The answer to part1 is #{part1('input.txt')}."

RSpec.describe "#{File.basename(__dir__)} examples" do
  context 'processing full files' do
    [
      [2, 'example.txt'],
      [0, 'invalid_passports.txt'],
      [4, 'valid_passports.txt']
    ].each do |amount, file_name|
      it "determines #{amount} passports are valid in #{file_name}" do
        expect(part1(file_name)).to eq(amount)
      end
    end
  end

  context 'passport validations' do
    subject { Passport.new }

    it 'considers byr 2002 valid' do
      subject.byr = '2002'
      expect(subject.byr).to eq(2002)
    end

    it 'considers byr 2003 valid' do
      subject.byr = '2003'
      expect(subject.byr).to be_nil
    end

    [
      %w[hgt 60in valid],
      %w[hgt 190cm valid],
      %w[hgt 190in invalid],
      %w[hgt 190 invalid],
      %w[hcl #123abc valid],
      %w[hcl #123abz invalid],
      %w[hcl 123abc invalid],
      %w[ecl brn valid],
      %w[ecl wat invalid],
      %w[pid 000000001 valid],
      %w[pid 0123456789 invalid]
    ].each do |property, value, status|
      it "considers #{property} #{value} #{status}" do
        subject.send("#{property}=", value)
        if status == 'valid'
          expect(subject.send(property)).to eq(value)
        else
          expect(subject.send(property)).to be_nil
        end
      end
    end
  end
end
