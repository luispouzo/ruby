require 'test_helper'

class ListingBooksTest < ActionDispatch::IntegrationTest
	setup do
		# creamos un genero de siencia ficcion y despues vamos a agregar la FK a las tablas
		@scifi = Genre.create!(name: 'Science Fiction')

		# --- Sin la relacion entre tablas ---
		# Book.create!(title: 'Pramatic Programmer', rating: 5)
		# Book.create!(title: "Ender's Game", rating: 4)

		# --- Con la relacion a Genres ---
		@scifi.books.create!(title: "Ender's Game", rating: 4)
		@scifi.books.create!(title: "Star Wars", rating: 5)
	end

	test 'listing books' do
		get '/api/books'
    	# sucess status code
    	assert_equal 200, response.status
    	# make sure that the response is in json format
    	assert_equal Mime::JSON, response.content_type

    	
    	# agregamos [:books] a nuestro json de respuesta cuando pusimos serializer.
    	# ahora se retorna una hash que aputa a un arreglo de books
    	books = json(response.body)[:books]
    	assert_equal Book.count, books.size
    	book = Book.find(books.first[:id])
    	assert_equal @scifi.id, book.genre.id
  	end

  	test 'list top rated books' do
  		get '/api/books?rating=5'

  		assert_equal 200, response.status
  		assert_equal Mime::JSON, response.content_type

  		assert_equal 1, json(response.body)[:books].size
  	end


end
