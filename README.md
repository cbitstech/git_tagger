# git_tagger

A Ruby Gem designed to expedite: the git tagging procedure and updating a changelog

## Installation

Add this line to your application's Gemfile:

```ruby
gem "git_tagger", "~> 1.X"
```

Add the following code to the project's Rakefile:

```ruby
git_tagger = Gem::Specification.find_by_name "git_tagger"
load "#{ git_tagger.gem_dir }/lib/tasks/deploy.rake"
```

And then execute:

```
$ bundle
...
Bundle complete! ...
Use `bundle show [gemname]` to see where a bundled gem is installed.
```

## Usage

Within the root directory of your application

- For full Rails applications:

    `rake deploy:tag`

- For Ruby Gems:

    `bundle exec rake deploy:tag`

## Contributing

1. Fork it [https://github.com/NU-CBITS/git_tagger/fork](https://github.com/NU-CBITS/git_tagger/fork)
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request
