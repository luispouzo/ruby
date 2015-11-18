require 'test_helper'

class ListingFinishedBooksTest < ActionDispatch::IntegrationTest

  setup do
  	Book.create!(title: 'Finished', finished_at: 1.day.ago)
  	Book.create!(title: 'Not Finished', finished_at: nil)
  end

  test "listing finished books in JSON" do
  	get '/api/finished_books', {}, {'Accept' =>'application/json'}

  	assert_equal 200, response.status
  	assert_equal Mime::JSON, response.content_type

  	assert_equal 1, json(response.body).size
  end

  test "listing finished books in XML" do
  	get '/api/finished_books', {}, {'Accept' =>'application/xml'}

  	assert_equal 200, response.status
  	assert_equal Mime::XML, response.content_type

    # La forma en que rails responde a xml es diferente a la que responde a json
    # Cuando responde a xml NO simplemente retorna un array con records sino que 
    # retorna un hash con el elemento root que apunta a ese arreglo.
    # En este caso el elemento root en el xml es books
  	assert_equal 1, Hash.from_xml(response.body)['books'].size
  end
end
