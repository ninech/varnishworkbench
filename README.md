# nine.ch Varnish Workbench

A simple Ruby on Rails application to play with, learn and test the [Varnish](https://www.varnish-cache.org/) web application accelerator, a caching reverse proxy.

Visit http://varnish.nine.ch/ for demo.

## Requirements

* Ruby
* Bundler
* Multiprocess web server
  * This App request pages from itself, this can result in deadlocks.
* Varnish
* A database

## Installation

    git clone https://github.com/ninech/varnishworkbench.git
    cd varnishworkbench
    bundle install --deployment

* Setup your web server to host the nine.ch Varnish Workbench Ruby on Rails application.
* Use the Varnish VCL from `public/varnishworkbench.vcl` and addapt it to your environment.

## Lincense

The nine.ch Varnish Workbench is released under the [MIT License](http://www.opensource.org/licenses/MIT). See LICENSE.txt for further details.
