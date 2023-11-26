require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 2
  end 

  test 'render a detailed product page' do 
    get product_path(products(:tenis))

    assert_response :success
    assert_select '.title', 'jordan'
    assert_select '.description', 'nuevos'
    assert_select 'price', '250$'
  end

      test 'render a new product form' do
     get new_product_path

     assert_response :success
     assert_select 'form'
  end

  test ' allows to create a new product ' do 
    post products_path, params: {
      product: {
        title: 'sandalia nike',
        description: 'usada',
        price: 84
      }
    }

    assert_response :redirected_to products_path 
    assert_equal flash[:notice], 'tu producto se ha creado correctamente'
  end

  test 'does nt allow to create a new product with empty fields ' do 
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

 test ' allows to update a product ' do 
  patch product_path(product(:tenis)), params: {
    product: {
      price: 165
    }
  }

  assert_response :redirected_to products_path 
  assert_equal flash[:notice], 'tu producto se ha actualizado correctamente'
  end

  test 'does not allow to update a product with an invalid field' do 
    patch product_path(product(:tenis)), params: {
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
   assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'
  end
end    