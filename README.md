# Varnish Workbench

The Varnish Workbench is a simple web application developed by [nine.ch](http://nine.ch) to play with, learn and test the [Varnish](https://www.varnish-cache.org) web application accelerator, a caching reverse proxy. It is intended to help web developers and system administrators understand how Varnish works and how it can be controled.

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

The Varnish Workbench is released under the [MIT License](http://www.opensource.org/licenses/MIT). See LICENSE.txt for further details.
