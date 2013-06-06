# HTML Compress #

A filter to provide simple HTML minification for
[Nanoc](http://nanoc.ws).

## Installation ##

Drop the file `html_compress.rb` into the `lib/filters` folder of
your Nanoc project.

Make sure you have
[Nokogiri](http://nokogiri.org)
in your `Gemfile`:

    gem 'nokogiri'

If necessary, re-run `bundle install`.

## Usage ##

Use the filter in `compile` rules as necessary. Examples:

    compile '*' do
        if item.binary?
            # don’t filter binary items
        else
            # Apply erb filter.
            filter :erb

            # Apply other filters.
            # filter ...

            # Apply html_compress filter.
            filter :html_compress
        end
    end

You can optionally output the errors found in your HTML by Nokogiri:

    filter :html_compress, :show_errors => true

This filter should only be used on HTML, so apply it after erb, markdown
and other filters which you may use.

## Details ##

The filter uses Nokogiri to parse the HTML and reduce the filesize in the
following basic ways:

- strip HTML comments (except conditional comments)

- remove leading whitespace in the `<head>` section

## Licence ##

Copyright 2013 ebargtuo. Released under the MIT license.