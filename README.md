# Summary

[![Code Climate](https://codeclimate.com/repos/5313bdf0695680405a00c039/badges/cd37fe1b53bc4d556c29/gpa.png)](https://codeclimate.com/repos/5313bdf0695680405a00c039/feed)
[![Build Status](https://travis-ci.org/Lordnibbler/spree_google_merchant.png?branch=2-2-stable)](https://travis-ci.org/Lordnibbler/spree_google_merchant)

Provides an up-to-date RSS product feed for Google Merchant rather a file that you have to upload. This is a very basic extension so feel free to help improve it!

To test and access the RSS feed visit:
`http://locahost:3000/google_merchant.rss`

## Installation & Usage

To start with you'll need a Google Merchant account. Then, add the gem to your `Gemfile`

```ruby
gem "spree_google_merchant", github: 'lordnibbler/spree_google_merchant.git'
```

Then bundle

```ruby
bundle install
```

Next, configure the feed title, description and site URL by browsing to the Google Merchant settings page in `Admin -> Configuration`

Finally, set up your products in Spree by editing the product's properties.  You should add the following properties:

```sh
google_product_type
manufacturer
brand
model
upc
```

## Testing
In order to run the rspec test suite:

```ruby
rake test_app
rake spec
```

Copyright (c) 2014 lordnibbler, released under the New BSD License
