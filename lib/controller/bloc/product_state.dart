import 'package:bytes_task/model/api_model.dart';

final class ProductState {
  final List<ListElement> products;
  final bool isLoading;
  final String? errorMessage;

  const ProductState({
    required this.products,
   this.isLoading = false,
   this.errorMessage
    
  });
}
