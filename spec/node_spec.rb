require 'spec_helper'

describe Flechtwerk do

  subject { Flechtwerk.new }

  let(:node) { subject.create_node }

  describe '#root' do
    it 'returns the root node' do
      subject.root['self'].must_equal 'http://localhost:7474/db/data/node/0'
    end
  end

  describe '#find_node' do
    it 'returns node data as Hash' do
      subject.find_node(0).must_be_kind_of(Hash)
    end

    it 'raises an exception when nothing is found' do
      -> { subject.find_node(-1) }.must_raise(Flechtwerk::NotFound)
    end
  end

  describe '#create_node' do
    it 'returns the newly created node' do
      subject.create_node['self'].must_match(/db\/data\/node\/\d+$/)
    end

    it 'sets attributes' do
      node = subject.create_node(name: 'Testnode', age: 23, birthday: Date.today)
      node['data'].must_equal({
        'birthday' => Date.today.to_s,
        'name' => 'Testnode',
        'age' => 23
      })
    end
  end

  describe '#update_node' do
    it 'changes existing attributes' do
      subject.update_node(node, { name: 'John Doe', age: 34 })
      subject.find_node(node)['data'].must_equal({
        'name' => 'John Doe',
        'age' => 34
      })
    end
  end

  describe '#update_node' do
    it 'changes one property but does not touch the rest' do
      subject.update_node(node, { name: 'John Doe', age: 34 })
      subject.update_node_property(node, 'age', 35)
      subject.find_node(node)['data'].must_equal({
        'name' => 'John Doe',
        'age' => 35
      })
    end
  end

  describe '#delete_node_property' do
    it 'changes one property but does not touch the rest' do
      subject.update_node(node, { name: 'John Doe', age: 34 })
      subject.delete_node_property(node, 'age')
      subject.find_node(node)['data'].must_equal({
        'name' => 'John Doe'
      })
    end
  end

  describe '#delete_node' do
    it 'should delete nodes' do
      subject.delete_node(node)
      -> { subject.find_node(node) }.must_raise(Flechtwerk::NotFound)
    end

    it 'should fail when the node has relationships'
  end

end