require 'test_helper'

class DeletingBooksTest < ActionDispatch::IntegrationTest
  setup do
  	@book = Book.create!(title: 'Pragmatic Programmer')
  end

  test "delete books" do
  	delete "/api/books/#{@book.id}"

  	# 204: respuesta satisfactoria con un body vacio
  	assert_equal 204, response.status
  end
end
