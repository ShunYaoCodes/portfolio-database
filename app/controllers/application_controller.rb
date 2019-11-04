class ApplicationController < ActionController::API
    def get_secret
        ENV['JWT_SECRET']
    end

    def generate_token
        payload = {
            username: @user.username,
            id: @user.id,
            exp: 2.hours.from_now.to_i
        }

        # IMPORTANT: set nil as password parameter
        JWT.encode payload, get_secret(), 'HS256'
    end

    def get_token
        request.headers["Authorization"]
    end

    def get_decoded_token
        token = get_token()
        begin
            decoded_token = JWT.decode token, get_secret(), true, { algorithm: 'HS256' }
            # Check decoded_token payload for expiration date.
        rescue JWT::DecodeError
            return {error: "Invalid Token"}
        rescue JWT::ExpiredSignature
            # Handle expired token, e.g. logout user or deny access
            return {error: "Token Expired"}
        end

        decoded_token
    end

    def is_authenticated?
        !!get_decoded_token
    end

    def requires_login
        if decode_error = get_decoded_token[:error]
            case decode_error
            when "Invalid Token"
                render json: {
                message: "Invalid Token"
                }, status: :unauthorized
            when "Token Expired"
                render json: {
                message: "Token Expired"
                }, status: :unauthorized
            end
        end
    end

    def requires_user_match
        @user = User.find_by(id: params[:user_id] ? params[:user_id] : params[:id])
        # byebug
        if @user.id != get_decoded_token[0]["id"]
            render json: {
            message: "Not your snacks!!!!!! Treat yourself!"
            }, status: :unauthorized
        end
    end
end
