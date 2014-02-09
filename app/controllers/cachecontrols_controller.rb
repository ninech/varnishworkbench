class CachecontrolsController < ApplicationController

    respond_to :html, :json, :js

    def edit
        @cachecontrol = CacheControl.find_or_initialize_by(ip: request.remote_ip)
    end

    def update
        @cachecontrol = CacheControl.find_or_initialize_by(ip: request.remote_ip)

        @state = @cachecontrol.update(params[:cachecontrol].permit(
            :expire,
            :noCache,
            :noStore,
            :public,
            :private,
            :maxAge,
            :sMaxAge
        ))

        respond_to do |format|
            format.html  { render 'edit' }
            format.json  { render :json => {state: @state } }
            format.js    { render :json => {state: @state }, :callback => params[:callback] }
        end
    end

    private
      def post_params
        params.require(:cachecontrol).permit(
            :expire,
            :noCache,
            :noStore,
            :public,
            :private,
            :maxAge,
            :sMaxAge
        )
      end


end
