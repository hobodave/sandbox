# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
node = Node.create({ metadata: { foo: 'bar' } })
puts "*" * 90
puts "Node ID: #{node.id}"
puts "*" * 90
puts "Copy the following line and use in console to enqueue jobs:"
puts
puts "    AsyncWorker.perform_async({ node_class: 'Node', node_id: '#{node.id}' })"
puts
puts "e.g. 10.times { <paste here> }"