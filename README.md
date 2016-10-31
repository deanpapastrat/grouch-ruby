# Grouch-Ruby

**Grouch is not in any way approved by or affiliated with Georgia Tech.**

Grouch is a tool to gather data from the Georgia Tech's OSCAR Course registration tool and parse it into a machine readable format that's easy for programmers to use.

## A Little Bit About Grouch

### Overview & History

Grouch was originally written in Python - this is a Ruby port. You can find the original Grouch source code at [gttools/Grouch](https://github.com/gttools/Grouch). There are, however, some differences between the Python and Ruby versions, mostly having to do with code organization and dependencies given the way the Ruby ecosystem typically works.

ruby-grouch is separated into 2 main projects: **ruby-grouch** (this project) a gem which serves as an API wrapper and the yet-to-be-started **ruby-grouch-api**, a Rails-based server which will spider the course catalog and automatically load the data into a database for rapid access.

<br/>

### What Ruby-Grouch Does

What ruby-grouch lets you do:

- Make direct URL requests to the course catalog and return the result as Grouch objects
- Query for classes by term, school, etc.
- Use responses with a standardized set of objects that make manipulating the data a snap

<br/>

### On Code Organization

**Why didn't you bundle the server into the gem?**

We separated the entire web api into a separate project so that we could abide by the principle of separation of concerns and keep this gem slim.

**Why are there so many entities inside ruby-grouch? Isn't that unnecessary?**

We wanted to make ruby-grouch super easy for people to use and follow object-oriented standards. By packaging all of the responses into dedicated Ruby objects instead of a giant hash or JSON blob, it makes it much easier to document, test, and explain.

**Are you doing test-driven development?**

Absolutely! We generally start by designing the Public API for the fetures we're trying to build, then write documentation and tests, and finally implement the features. We'd be happy to have help with any part of building features - whether it's testing, documenting, or implementing.

**How much documentation do you like to provide?**

We like to provide very thorough documentation for the project, including examples for every public API method. Please follow the conventions set in files such as `course.rb` for documenting and you'll be good to go!

**You said this project is a work in progress. How can I see what you've done so far?**

We have auto-generated docs available from our WIP at [RubyDoc](http://www.rubydoc.info/gems/grouch).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grouch'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grouch

## Usage

This gem is a work in progress. Don't use it!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deanpapastrat/grouch-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

