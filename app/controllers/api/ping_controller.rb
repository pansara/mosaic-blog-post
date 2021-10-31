class Api::PingController < Api::ApiController
    def index
		render json: {"success": true}
    end
end
