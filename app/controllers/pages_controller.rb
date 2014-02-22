class PagesController < ApplicationController

    respond_to :html, :json, :js

    def edit
        @page = Page.find_or_initialize_by(ip: remote_ip)
    end

    def show
        @cachecontrol = CacheControl.find_or_initialize_by(ip: remote_ip)

        if @cachecontrol.header_expire
            response.headers["Expires"] = @cachecontrol.header_expire
        end
        if @cachecontrol.header_cachecontrol
            response.headers["Cache-Control"] = @cachecontrol.header_cachecontrol
        end

        @page = Page.find_or_initialize_by(ip: remote_ip)

        sleep @cachecontrol.timeout

        respond_to do |format|
            format.html  { render }
            format.json  { render :json     => @page }
            format.js    { render :json     => @page,
                                  :callback => params[:callback] }
        end
    end

    def update
        @page = Page.find_or_initialize_by(ip: remote_ip)

        @state = @page.update(params[:page].permit(:title, :text))

        respond_to do |format|
            format.html  {
                if @state
                    render 'show'
                else
                    render 'edit'
                end
            }
            format.json  { render :json     => {state: @state } }
            format.js    { render :json     => {state: @state },
                                  :callback => params[:callback] }
        end
    end

    private
        def post_params
            params.require(:page).permit(:title, :text)
        end

end
