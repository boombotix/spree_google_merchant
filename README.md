Summary
=======

Provides an up-to-date RSS product feed for Google Merchant rather a file that you have to upload. This is a very basic extension so feel free to help improve it!

To test and access the RSS feed visit:

    http://locahost:3000/google_merchant.rss

Installation & Usage
--------------------

To start with you'll need a Google Merchant account. Then, add the gem to your `gemfile`

    gem "spree_google_merchant", github: 'lordnibbler/spree_google_merchant.git'

Then bundle

    bundle install

Next, configure the feed title, description and site URL by browsing to the Google Merchant settings page in `Admin -> Configuration`

Finally, set up your products in Spree by editing the product's properties.  You should add the following properties:

    google_product_type
    manufacturer
    brand
    model
    upc

Copyright (c) 2013 lordnibbler, released under the New BSD License
