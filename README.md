# Riker

[![Version](https://img.shields.io/gem/v/riker.svg?style=flat-square)](https://rubygems.org/gems/riker)
[![Test](https://img.shields.io/github/workflow/status/benfalk/riker/Test?label=Test&style=flat-square)](https://github.com/benfalk/riker/actions?query=workflow%3ATest)

<img src="./assets/commander-riker.jpeg" />

High-Performance, Dependency-Free Command Pattern For Ruby

## Simple Usage

### In your gemfile:

```ruby
gem 'riker', '0.1.0.pre2'
```

### In your code:

```ruby
class SimpleGreeting
  extend Riker

  param :first_name
  param :last_name, required: false

  execute do
    "Hello #{first_name} #{last_name}".strip
  end
end
```

### In use:

```ruby
SimpleGreeting.run!(first_name: 'Will')
# => "Hello Will

SimpleGreeting.run!(first_name: 'Will', last_name: 'Riker')
# => "Hello Will Riker
```
