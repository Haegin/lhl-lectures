# Gems and Bundler

Bundler is used to manage the gems used in a Ruby project. It references a configuration file called `Gemfile`, which works similarly to the `dependencies` part of `package.json`.

Anytime you see a `Gemfile` in a project, you should run `bundle install`. Bundler will then auto-generate a `Gemfile.lock` file, which contains information on all gem dependencies (similar to the `node_modules` directory). You should **not** edit `Gemfile.lock` manually; it will be generated automatically every time `bundle install` or `bundle update` is executed.

Once this is in place, use the `bundle exec` command to run any ruby files that depend on the gems listed inside your `Gemfile`.

# Intro to ActiveRecord

_ActiveRecord_ is a Ruby gem that implements the _active record_ pattern, providing ways to talk to a database using object oriented programming. It's a very popular gem that's included by default in Ruby on Rails, and it's one of the main reasons for its success.

The documentation on ActiveRecord (the gem) is extensive and excellent. Be sure to check it out:

* Querying: http://guides.rubyonrails.org/active_record_querying.html
* Validations: http://guides.rubyonrails.org/active_record_validations.html
* Associations: http://guides.rubyonrails.org/association_basics.html

## Topics:

* Introducing Comments
* More Associations
  - `Post.joins(comments: :user).where(users: {id: user.id})`
  - `has_many :commented_posts, through: :comments, source: :post`
* Callbacks
  - Adding a published_at timestamp automatically when a model is saved.
* Validations
  - simple private method validations
  - custom validators
* Scopes
  - Easier to do common queries
  - `Post.published`
  - `Post.published_before(date)`
  - Work with chaining normally.

## Code

The code discussed in class can be found inside [`/code`](code). Note this is code created **exclusively** to demonstrate `ActiveRecord` in class, so all tables will be destroyed every time [`setup.rb`](code/setup.rb) is run.
