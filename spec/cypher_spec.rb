require 'spec_helper'

describe 'Flechtwerk Cypher Integration', Flechtwerk do

  subject { Flechtwerk.new }

  describe '#exec_cypher' do
    it 'Creates and returns a single node' do
      query = %(CREATE (a {name:'Testnode'}) RETURN a)
      subject.exec_cypher(query)['data'].size.must_equal 1
    end
  end

end