# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Department.delete_all
user = User.create! :first_name => 'admin',:last_name => 'admin', :email => 'vivakk.pits@yahoo.com', :password => 'qwerty', :password_confirmation => 'qwerty',:role=>0
['HR','Sales','Finance','Marketing'].each do |dep|
	Department.create! :name=>dep
end	