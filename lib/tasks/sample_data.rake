namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "fed",
                         email: "fed@email.com",
                         school: "uci",
                         password: "password1",
                         password_confirmation: "password1")
    admin.toggle!(:admin)

    User.create!(name: "luna",
                 email: "luna@email.com",
                 school: "uci",
                 password: "password",
                 password_confirmation: "password")

    99.times do |n|
      name = "luna#{n+1}"
      email = "#{name}@email.com"
      password = "password"
      User.create!(name: name,
                   email: email,
                   school: "uci",
                   password: password,
                   password_confirmation: password)
    end

    users = User.all.limit(10)

    50.times do
      title = Faker::Lorem.sentence
      content = Faker::Lorem.paragraph
      price = Faker::Number.decimal(2)
      preferred_contact = Faker::Internet.email
      location = Faker::Address.city + " " + Faker::Address.state + " " + Faker::Address.zip_code

      users.each { |user| user.advertisements.create!(title: title,
                                                      content: content,
                                                      price: price,
                                                      preferred_contact: preferred_contact,
                                                      location: location
        )}
    end
  end
end
