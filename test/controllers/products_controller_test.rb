require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 28
    assert_select '.category', 13
  end

  test 'render a list of products filtered by category' do
    get products_path(category_id: categories(:footwear).id)

    assert_response :success
    assert_select '.product', 5
  end

  test 'render a list of products filtered by min_price and max_price' do
    get products_path(min_price: 10, max_price:200)

    assert_response :success
    assert_select '.product', 3
    assert_select 'h2', 'jordan'   
  end

  test 'search a product by query_text' do
    get products_path(min_price: 10, max_price:200)

    assert_response :success
    assert_select '.product', 1
    assert_select 'h2', 'jordan'   
  end

  test 'sort products by expensive prices first' do
    get products_path(order_by: 'expensive')

    assert_response :success
    assert_select '.product', 12
    assert_select '.products .product:first-child h2', 'jordan'   
  end 

  test 'sort products by cheapest prices first' do
    get products_path(order_by: 'cheapest')

    assert_response :success
    assert_select '.product', 12
    assert_select '.products .product:first-child h2', 'chaqueta'   
  end 

  test 'render a detailed product page' do
    get products_path(query_text: 'jordan')

    assert_response :success
    assert_select '.title', 'jordan'
    assert_select '.description', 'nuevos'
    assert_select '.price', '250$'
  end

  test 'render a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test 'allows to create a new product' do
    post products_path, params: {
      product: {
        title: 'sandalia nike',
        description: 'usada',
        price: 84,
        category_id: categories(:clothes).id
      }
    }

    assert_redirected_to products_path
    assert_equal 'tu producto se ha creado correctamente', flash[:notice]
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: 'botas nike',
        description: 'usada',
        price: 84
      }
    }

    assert_response :unprocessable_entity
  end

  test 'render an edit product form' do
    get edit_product_path(products(:tenis))

    assert_response :success
    assert_select 'form'
  end

  test 'allows to update a product' do
    patch product_path(products(:tenis)), params: {
      product: {
        price: 165
      }
    }

    assert_redirected_to products_path
    assert_equal 'tu producto se ha actualizado correctamente', flash[:notice]
  end

  test 'does not allow to update a product with an invalid field' do
    patch product_path(products(:tenis)), params: {
      product: {
        price: nil
      }
    }

    assert_response :unprocessable_entity
  end

  test 'can delete products' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:tenis))
    end

    assert_redirected_to products_path
    assert_equal 'Tu producto se ha eliminado correctamente', flash[:notice]
  end
end