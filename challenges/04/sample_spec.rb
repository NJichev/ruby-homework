require 'rspec'
require_relative 'solution'

RSpec.describe 'DrunkProxy' do
  it 'calls targets methods' do
    string = 'hello'
    number = 2.3
    proxy = DrunkProxy.new [string, number]

    expect(proxy.length).to eq [string.length]
    expect(proxy.floor).to eq [number.floor]
  end

  it 'raises NoMethodError if none respond' do
    string = 'hello'
    number = 2.3
    hash = { name: 'foo' }
    proxy = DrunkProxy.new [string, number, hash]

    expect { proxy.bar }.to raise_error NoMethodError
  end

  it 'does harder stuff' do

    proxy = DrunkProxy.new [-42, 'foo', 'bar baz', [2, 3, 5, 8]]
    expect(proxy.reverse).to eq ["oof", "zab rab", [8, 5, 3, 2]]
    expect(proxy.abs).to eq [42]
    expect(proxy.length).to eq [3, 7, 4]
  end

  it 'does meta stuff' do
    proxy = DrunkProxy.new ['foo', [24], {x: 2}]
    expect(proxy.class).to eq [String, Array, Hash]
  end
end
