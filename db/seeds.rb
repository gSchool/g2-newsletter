# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This seed will create 10 publications that match 10 test publications in the Stripe Dashboard.do
# You will need to delete all other publications made.do
# All publications created via the Newsletter App will now create a new plan in Stripe

@counter = 1

10.times do
  publication = Publication.create!(
    :name => "Name#{@counter}",
    :description => 'Description'
  )
  @counter += 1
end