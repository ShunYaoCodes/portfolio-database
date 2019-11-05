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
        rescue JWT::DecodeError
            return nil
        rescue JWT::ExpiredSignature
            return nil
        end

        decoded_token
    end

    def is_authenticated?
        !!get_decoded_token
    end

    def requires_login
        if !is_authenticated?
            render json: {
            message: "Invalid Token or Token Expired"
            }, status: :unauthorized
        end
    end

    def requires_user_match
        @user = User.find_by(id: params[:user_id] ? params[:user_id] : params[:id])
        
        if @user.id != get_decoded_token[0]["id"]
            render json: {
            message: "User Doesn't Match"
            }, status: :unauthorized
        end
    end
end
