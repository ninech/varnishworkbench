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

end
