require 'pry' # incase you want to use binding.pry
require 'active_record'
require 'active_support/all'
require_relative 'lib/user'
require_relative 'lib/post'
require_relative 'lib/comment'

# Output messages from AR to STDOUT
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing connection to database ..."
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  pool: 5,
  database: 'lhl_week6',  # Change this to your database name,
  username: 'harry', # user name
  password: '',      # and password (if any)
  host: 'localhost',
  port: 5432,
  min_messages: 'error'
)
puts "CONNECTED"

puts "Setting up Database (recreating tables) ..."

ActiveRecord::Schema.define do
  drop_table :users if ActiveRecord::Base.connection.data_source_exists?(:users)
  drop_table :posts if ActiveRecord::Base.connection.data_source_exists?(:posts)
  drop_table :comments if ActiveRecord::Base.connection.data_source_exists?(:comments)

  create_table :users do |t|
    t.column :name, :string
    t.column :email, :string
    t.column :admin, :boolean
    t.timestamps null: false
  end

  create_table :posts do |table|
    table.references :user
    table.column :title, :string
    table.column :body, :string
    table.column :published, :boolean
    table.column :published_at, :datetime, null: true
    table.timestamps null: false
  end

  create_table :comments do |table|
    table.references :post
    table.references :user
    table.column :comment, :string
    table.timestamps null: false
  end
end

puts "Setup DONE"



# Create example data
def populate
  require 'faker'

  3.times do

    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      admin: (rand(2) > 0)
    )
  end

  users = User.all.to_a
  20.times do
    post = Post.create!(
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph,
      published: (rand(2) > 0),
      user_id: users.sample.id
    )

    5.times do
      Comment.create!(
        comment: Faker::Lorem.paragraph,
        post_id: post.id,
        user_id: users.map(&:id).without(post.user_id).sample
      )
    end
  end
end

populate

user = Post.all.sample.user
commentor = user.posts.find { |p| p.comments.count > 0 }.comments.first.user

binding.pry
