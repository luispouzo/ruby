require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  test "creates new books with valid data" do
  	post '/api/books', { book: {
  		title: 'Pragmatic Programmer',
  		rating: 5,
  		author: 'Dave Thomas',
  		genre_id: 1,
  		review: 'Excellent book for any programmer.',
  		amazon_id: '13123'
  		} }.to_json, 
  		{ 'Accept' => 'application/json', 
  		  'Content-Type' => 'application/json' }

  	assert_equal 201, response.status
  	assert_equal Mime::JSON, response.content_type
  	
  	# aca ponemos book en nuestro response porque es un solo book y lo que hace serilizer es
  	# llamar al objeto del modelo (book) y no a la coleccion. Entonces en ves de books tenemos book
  	book = json(response.body)[:book]

  	# estamos referenciando la propiedad en el hash de books como simbolo.
  	# Entonces debemos estar seguros de que el metodo json de ayuda combierta a simbolo
  	# la respuesta. Entonces en nuetro metodo json de test_helper.rb debemos agregar 
  	# un parametro para combertir los nombres a simbolos 
  	# ej: convertir de {'name'=>'foo'} a {':name'=>'foo'}
  	assert_equal api_book_url(book[:id]), response.location 
  	# api_book_url es el path api/book/

  	assert_equal 'Pragmatic Programmer', book[:title]
  	assert_equal 5, book[:rating].to_i
  	assert_equal 'Dave Thomas', book[:author]
  	assert_equal 1, book[:genre_id].to_i
  	assert_equal 'Excellent book for any programmer.', book[:review]
  	assert_equal '13123', book[:amazon_id]

  end

  test "does not create new books with valid data" do
  	post '/api/books', { book: {
  		title: nil,
  		rating: 5
  		} }.to_json, 
  		{ 'Accept' => 'application/json', 
  		  'Content-Type' => 'application/json' }

  	assert_equal 422, response.status
  end
end
