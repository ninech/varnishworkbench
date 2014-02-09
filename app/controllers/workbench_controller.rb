class WorkbenchController < ApplicationController

    def index
    end

    def workbench
        @cachecontrol = CacheControl.find_or_initialize_by(ip: request.remote_ip)
        @page = Page.find_or_initialize_by(ip: request.remote_ip)
    end

end
