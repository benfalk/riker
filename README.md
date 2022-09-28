# Riker

[![Version](https://img.shields.io/gem/v/riker.svg?style=flat-square)](https://rubygems.org/gems/riker)
[![Test](https://img.shields.io/github/workflow/status/benfalk/riker/Test?label=Test&style=flat-square)](https://github.com/benfalk/riker/actions?query=workflow%3ATest)

<img src="./assets/commander-riker.jpeg" />

High-Performance, Dependency-Free Command Pattern For Ruby

## Simple Usage

### In your gemfile:

```ruby
gem 'riker', '0.1.0.pre3'
```

### In your code:

```ruby
class SimpleGreeting
  extend Riker

  param :first_name
  param :last_name, required: false
  param :punctuation, default: '.'

  execute do
    return "Hello #{first_name}#{punctuation}" if last_name.nil?

    "Hello #{first_name} #{last_name}#{punctuation}"
  end
end
```

### In use:

```ruby
SimpleGreeting.run!(first_name: 'Will')
# => "Hello Will."

SimpleGreeting.run!(first_name: 'Will', last_name: 'Riker')
# => "Hello Will Riker."

SimpleGreeting.run!(first_name: 'Will', last_name: 'Riker', punctuation: '!')
# => "Hello Will Riker!"
```

## Default Procs

### In your code:

```ruby
class CaptainsLog
  extend Riker

  param :stardate, default: -> { Time.now.to_f }
  param :message

  execute do
    "Captain's Log; Stardate: #{stardate}\n\n#{message}"
  end
end
```

### In use:

```ruby
CaptainsLog.run!(message: "The Borg are attacking!")
# => "Captain's Log; Stardate: 1664393978.915553\n\nThe Borg are attacking!"

CaptainsLog.run(message: "We've traveled back in time!", stardate: 42.1337)
# => "Captain's Log; Stardate: 42.1337\n\nWe've traveled back in time!"
```
