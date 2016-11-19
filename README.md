[![Gem Version](https://badge.fury.io/rb/cogwheels.svg)](http://badge.fury.io/rb/cogwheels)
[![Dependency Status](https://gemnasium.com/badges/github.com/chrisblutz/cogwheels.svg)](https://gemnasium.com/github.com/chrisblutz/cogwheels)
[![Linux Build Status](https://travis-ci.org/chrisblutz/cogwheels.svg?branch=master)](https://travis-ci.org/chrisblutz/cogwheels)
[![Inline docs](http://inch-ci.org/github/chrisblutz/cogwheels.svg?branch=master)](http://inch-ci.org/github/chrisblutz/cogwheels)
[![Test Coverage](https://codeclimate.com/github/chrisblutz/cogwheels/badges/coverage.svg)](https://codeclimate.com/github/chrisblutz/cogwheels/coverage)
[![Code Climate](https://codeclimate.com/github/chrisblutz/cogwheels/badges/gpa.svg)](https://codeclimate.com/github/chrisblutz/cogwheels)

# Cogwheels

**Cogwheels** is a lightweight configuration-loading library for Ruby.

## Installation

To install, use the standard RubyGems syntax:
```sh
$ gem install cogwheels
```
Or if necessary, you can add it to your `Gemfile`:
```rb
gem 'cogwheels'
```
As **Cogwheels** is not yet at version `1.0`, it is recommended to use version locking:
```rb
gem 'cogwheels', '~> 0.2'
```

## Usage

Assuming you have already installed the `cogwheels` gem or added it to your `Gemfile`, the first step
is to require it:
```rb
require 'cogwheels'
```
You can load the configuration file into a `Cogwheels::Configuration` object using the following:
```rb
config = Cogwheels.load('.../file.yml')
```
This `config` object uses methods similar to those in a `Hash` object:
```rb
config[:key] # Retrieves the value for a key

config.key?(:key) # Checks if a value exists for a key

config[:key] = 'value' # Sets the value for a key
```
However, the basic retrieval method (`config[:key]`) also takes a default value as an optional parameter:
```rb
config[:key, 'default'] # Retrieves the value for a key, specifying a default value
```
If for any reason you need the original `Hash` object, you can call `config.hash` to retrieve it.

### Mutability

By default, `Configuration` instances are *mutable*, which means their values can be altered at any time.  However, you can lock editing on a configuration tree by passing a second parameter to the `load` method:
```rb
config = Cogwheels.load('.../file.yml', false)
```
Now, whenever an edit is attempted (such as `config[:key] = 'value'`), an `ImmutableConfigurationError` will be raised.

### Symbols As Keys

If needed, `Configuration` objects can be forced to convert *all* of their keys to symbols:
```rb
config.to_symbol_keys
```
So if this file is passed in:
```yml
Test: value
```
the value can be retrieved using:
```rb
config[:Test]
```

## Copyright

Copyright (c) 2016 Christopher Lutz.  See [LICENSE.txt](LICENSE.txt) for further details.
