module Api	
	class BooksController < ApplicationController
		def index
			books = Book.all

			# filters
			if rating = params[:rating]
				books = books.where(rating: rating)
			end

			render json: books, status: 200
		end

		def create
			book = Book.new(book_params)
			if book.save
				render json: book, status: 201, location: [:api,book]
			else
				render json: book.errors, status: 422
			end
		end

		def destroy
			book = Book.find(params[:id])
			book.destroy!

			# Si queremos retornar un response con un body vacio debemos poner render nothing: true
			# y si queremos ser mas explicitos ponemos status: 204
			render nothing: true, status: 204
		end

		def book_params
			params.require(:book).permit(:title, :rating, :author, :genre_id, :review, :amazon_id)
		end
	end
end