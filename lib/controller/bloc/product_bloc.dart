import 'package:bytes_task/controller/bloc/product_events.dart';
import 'package:bytes_task/controller/bloc/product_state.dart';
import 'package:bytes_task/model/api_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ProductBloc extends Bloc<ProductEvents, ProductState> {
  ProductBloc() : super(ProductState(products: [])) {
    on<FetchProductsEvent>(_fetchProducts);
  }

  Future <void> _fetchProducts(FetchProductsEvent event,Emitter<ProductState>emit) async{
    //starts loading
     emit(ProductState(
      products: state.products,
      isLoading: true,
    ));

     try {
      // Fetch products from API
      final products = await ListElement.fetchProducts();

      // Emit the loaded state with the fetched products
      emit(ProductState(
        products: products,
        
        isLoading: false,
      ));
    } catch (e) {
      // Emit error state if API call fails
      emit(ProductState(
        products: state.products,
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }

  }
}
