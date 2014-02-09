require 'date'

class CacheControl < ActiveRecord::Base

    after_initialize :init

    def init
        self.expire  ||= 'now'
        self.noCache ||= false
        self.noStore ||= false
        self.public  ||= false
        self.private ||= false
        self.maxAge  ||= 0
        self.sMaxAge ||= 0
        self.timeout ||= 1
    end

    def header_expire
        case self.expire
        when 'now'
            DateTime.now.httpdate
        when '60'
            (DateTime.now.to_time+60).to_datetime.httpdate
        when '3600'
            (DateTime.now.to_time+3600).to_datetime.httpdate
        else
            nil
        end
    end

    def header_cachecontrol
        @h = []
        if self.noCache
            @h << 'no-cache'
        end
        if self.noStore
            @h << 'no-store'
        end
        if self.public
            @h << 'public'
        end
        if self.private
            @h << 'private'
        end
        if self.maxAge > 0
            @h << %Q{max-age:#{self.maxAge}}
        end
        if self.sMaxAge > 0
            @h << %Q{s-maxage:#{self.sMaxAge}}
        end
        @h.join(', ')
    end

end
