# Flechtwerk

The aim of _flechtwerk_ is to provide a very minimal wrapper for the neo4j graph
database. There are other alternatives which might be much more feature rich, but
this gem will remain very barebone.

## Installation

Add this line to your application's Gemfile:

    gem 'flechtwerk'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flechtwerk

## Usage

Create a connection object

    graph = Flechtwerk.new

Get the root node for the graph

    graph.root

Find a specific node by its it or node hash

    graph.find_node(id)

Create a new node

    graph.create_node # empty node
    graph.update_node(id, { name: 'Testnode', size: 12 })

Change a nodes attributes

    graph.update_node(id, { name: 'Married node', age: 35 }) # resets all attributes
    graph.update_node_property(id, 'name', 'New name') # only changes the name attribute
    graph.delete_node_property(id, 'name') # removes only the name attribute

Delete a node

    graph.delete_node(id)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
