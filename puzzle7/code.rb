# frozen_string_literal: true

require 'debug'
require 'spec_helper'

class Bag
  attr_accessor :name, :parents, :children

  def initialize(name, children = nil)
    @name = name
    @children = children
    @parents = []
  end

  def ancestors
    grandparents = parents.map(&:ancestors)
    immediate_parents = parents.map(&:name)
    immediate_parents + grandparents
  end
end

class Ruleset
  class << self
    def my_accessor(*attributes)
      attributes.each do |attribute|
        my_reader(attribute)
        my_writer(attribute)
      end
    end

    def my_reader(attribute)
      define_method(attribute) do
        instance_variable_get("@#{attribute}")
      end
    end

    def my_writer(attribute)
      define_method("#{attribute}=") do |attribute_param|
        instance_variable_set("@#{attribute}", attribute_param)
      end
    end
  end

  def known_bags
    instance_variables.map { |v| v.to_s[1..] }
  end

  def link_parents_of(new_bag)
    known_bags.each do |potential_parent|
      children = send(potential_parent).children.keys
      send(new_bag).parents << send(potential_parent) if children.include?(new_bag)
    end
  end
end

def input_file(file_name)
  File.readlines("#{__dir__}/#{file_name}")
end

def parse_rule(rule)
  new_color = rule.match(/(?<new_color>\w*\s\w*)/)[:new_color].gsub(' ', '_')
  children_str = rule.match(/contain (?<children>.*)/)[:children].split(',')
  children = {}
  children_str.each do |child|
    next if child == 'no other bags.'

    capacity = child.match(/(?<capacity>\d)/)[:capacity].to_i
    bag_color = child.match(/\d\s(?<bag_color>\w*\s\w*)/)[:bag_color].gsub(' ', '_')
    children[bag_color.to_sym] = capacity
  end
  Bag.new(new_color, children)
end

def construct_rules(rules)
  ruleset = Ruleset.new

  rules.each do |rule|
    bag = parse_rule(rule)
    bag_name = bag.name

    Ruleset.my_accessor(bag_name.to_sym)
    ruleset.send("#{bag_name}=", bag)
  end

  ruleset.known_bags.each do |bag|
    ruleset.link_parents_of(bag.to_sym)
  end

  ruleset
end

def identify_parents_of(bag)
  bag.ancestors.flatten.uniq
end

def part1(file_name, bag_color)
  rules = input_file(file_name)

  ruleset = construct_rules(rules)
  bag = ruleset.send(bag_color.gsub(' ', '_'))
  identify_parents_of(bag).length
end

def part2(file_name)
  4
end

puts "The answer to part1 is #{part1('input.txt', 'shiny gold')}."
# puts "The answer to part2 is #{part2('input.txt')}."

RSpec.describe "#{File.basename(__dir__)} examples" do
  context 'testing parse_rule' do
    [
      ['light red bags contain 1 bright white bag, 2 muted yellow bags.',
       'light_red', { 'bright_white': 1, 'muted_yellow': 2 }],
      ['dark orange bags contain 3 bright white bags, 4 muted yellow bags.',
       'dark_orange', { 'bright_white': 3, 'muted_yellow': 4 }],
      ['bright white bags contain 1 shiny gold bag.',
       'bright_white', { 'shiny_gold': 1 }],
      ['muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.',
       'muted_yellow', { 'shiny_gold': 2, 'faded_blue': 9 }],
      ['shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.',
       'shiny_gold', { 'dark_olive': 1, 'vibrant_plum': 2 }],
      ['dark olive bags contain 3 faded blue bags, 4 dotted black bags.',
       'dark_olive', { 'faded_blue': 3, 'dotted_black': 4 }],
      ['vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.',
       'vibrant_plum', { 'faded_blue': 5, 'dotted_black': 6 }],
      ['faded blue bags contain no other bags.', 'faded_blue', {}],
      ['dotted black bags contain no other bags.', 'dotted_black', {}],
      ['shiny fuchsia bags contain 2 dull silver bags, 1 wavy indigo bag, 5 shiny gold bags, 2 bright beige bags.',
       'shiny_fuchsia', { 'dull_silver': 2, 'wavy_indigo': 1, 'shiny_gold': 5, 'bright_beige': 2 }]
    ].each do |rule, name, children|
      it "parses '#{rule}' as #{name} with #{children} " do
        bag = parse_rule(rule)

        expect(bag.name).to eq(name)
        expect(bag.children).to eq(children)
      end
    end
  end

  [
    ['dotted black', 7],
    ['faded blue', 7],
    ['vibrant plum', 5],
    ['dark olive', 5],
    ['shiny gold', 4],
    ['muted yellow', 2],
    ['bright white', 2],
    ['dark orange', 0],
    ['light red', 0]
  ].each do |color, number|
    it "determines #{number} bags can contain #{color}" do
      expect(part1('example.txt', color)).to eq(number)
    end
  end
end
