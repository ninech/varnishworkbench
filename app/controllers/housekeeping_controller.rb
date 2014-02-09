require 'net/http'

class HousekeepingController < ApplicationController

    def refresh
        url = URI.parse('http://varnish.nine.ch/page')
        req = Net::HTTP::Get.new(url.path)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        render :json => {req: req, res: res}
    end

    def purge
    end

    def ban
    end
end
