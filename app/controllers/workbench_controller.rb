require 'coderay'

class WorkbenchController < ApplicationController

    def index
    end

    def vcl
        @vcl_path = Rails.public_path.to_s + '/varnishworkbench.vcl'

        @vcl_highlight = CodeRay.scan_file(@vcl_path, :c).html(
            :line_numbers => :inline,
            :css          => :style
        )
    end

    def workbench
        @cachecontrol = CacheControl.find_or_initialize_by(ip: remote_ip)
        @page = Page.find_or_initialize_by(ip: remote_ip)
    end

end
