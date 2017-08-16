# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
profile = Profile.create(first_name:"igor",last_name:"sioef",user_id:1)
profile = Profile.create(first_name:"mike",last_name:"lol",user_id:2)
profile = Profile.create(first_name:"Jon",last_name:"Snow",user_id:3)
