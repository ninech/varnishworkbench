class Page < ActiveRecord::Base

    after_initialize :init

    def init
        self.title ||= 'Varnish Workbench'
        self.text ||= 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren.'
    end

end
