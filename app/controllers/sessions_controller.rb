class SessionsController < ApplicationController
    def new

    end

    def create
        user = User.find_by(email: params[:email] ) 
        if user && user.authenticate(params[:password])
             session[:user_id] = user.id
             redirect_to (session[:intended_url] || user), notice: "Welcome back, #{user.name}!"
        else
         flash.now[:alert] = "Invalid email/password combination!"
         render :new, status: :unprocessable_entity
         session[:intended_url]  = nil
        end 
    end

    def destroy
        session[:user_id] = nil
        redirect_to :events, status: :see_other, notice: "You're now signed out!"
    end
end