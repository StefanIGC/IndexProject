# Article.delete_all
# Comment.delete_all
# User.delete_all
# Category.delete_all
# Tag.delete_all



5.times do
    Category.create!(
        name: Faker::Commerce.product_name,
    )
end

10.times do
    Tag.create!(
        name: Faker::Superhero.name
    )
end


# db/seeds.rb
1_000.times do
    User.create!(
      email: Faker::Internet.email,
      password: "secrete",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    )
end
  

2_000.times do
  Article.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    category_id: Category.all.sample.id,
    tag_id: Tag.all.sample.id,
    author_id: User.all.sample.id,
    published: [true, false].sample
  )
end


50_000.times do
  Comment.create!(
    content: Faker::Lorem.paragraph,
    rating: rand(1.0..5.0),
    user_id: User.all.sample.id,
    article_id: Article.all.sample.id
  )
end
