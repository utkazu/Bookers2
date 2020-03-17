class BooksController < ApplicationController
	def index
		@user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
	end

	def show
    @book_show = Book.find(params[:id])
		@user = User.find(@book_show.user_id)
    @book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "You have created book successfully."
			redirect_to book_path(@book.id)
		else
			@user = User.find(current_user.id)
			@books = Book.all
			render 'user/show'
		end
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user_id != current_user.id
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "You have updated book successfully."
			redirect_to book_path(@book.id)
		else
			render 'books/edit'
	end

	def destroy
	end


	private

	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end

end
