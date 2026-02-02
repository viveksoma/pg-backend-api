class AuthController < ApplicationController

    # POST /signup
    def signup
        user = User.new(user_params)

        if user.save
        render json: {
            message: 'Signup successful',
            user: {
            id: user.id,
            email: user.email
            }
        }, status: :created
        else
        render json: {
            error: user.errors.full_messages.join(', ')
        }, status: :unprocessable_entity
        end
    end

    # POST /login
    def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
        render json: {
            message: 'Login successful',
            user: {
            id: user.id,
            email: user.email
            }
        }, status: :ok
        else
        render json: {
            error: 'Invalid email or password'
        }, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end 
end
