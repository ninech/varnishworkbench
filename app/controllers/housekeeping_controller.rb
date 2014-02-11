require 'http'
require 'net/http'

class HousekeepingController < ApplicationController

    def refresh
        url = URI.parse('http://varnish.nine.ch/page')
        req = Net::HTTP::Refresh.new(url.path)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }

        ret = {
            code: res.code,
            out: [
                %Q{#{req.method} #{req.path} HTTP/1.1}
            ],
            in: [
                %Q{HTTP/#{res.http_version} #{res.code} #{res.message}}
            ]
        }

        render :json     => ret,
               :callback => params[:callback]
    end

    def purge
        url = URI.parse('http://varnish.nine.ch/page')
        req = Net::HTTP::Purge.new(url.path)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }

        ret = {
            code: res.code,
            out: [
                %Q{#{req.method} #{req.path} HTTP/1.1}
            ],
            in: [
                %Q{HTTP/#{res.http_version} #{res.code} #{res.message}}
            ]
        }

        render :json     => ret,
               :callback => params[:callback]
    end

    def ban
        url = URI.parse(request.original_url)
        req = Net::HTTP::Ban.new('/page', {
            'X-Ban-Host' => request.headers['Host'],
            'X-Ban-Url' => '/page.*',
        })
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        render :json => {req: req, res: res},
               :callback => params[:callback]
    end

end
