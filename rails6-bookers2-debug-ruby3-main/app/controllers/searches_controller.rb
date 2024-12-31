class SearchesController < ApplicationController
    before_action :authenticate_user!
    def search
        @range = params[:renge]
        @word = params[:word]

        if @range == "User"
            @user = User.looks(params[:search], params[:word])
        else
            @books = Book.looks(params[:search], paramas[:word])
        end
    end
end
