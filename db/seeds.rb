# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Task.find_or_create_by_title('Wash dishes', {:due => Date.today+1, :priority => 12}, :without_protection => true)
Task.find_or_create_by_title('Walk dog', {:description => 'Feed him, too', :due => Date.today+2, :priority => 1}, :without_protection => true)
Task.find_or_create_by_title('Pay for language courses', {:description => 'uhh', :due => Date.today+2, :priority => 1}, :without_protection => true)
