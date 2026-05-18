import 'package:bloc/bloc.dart';
import '../data/model/product_model.dart';
import '../data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  List<ProductModel> products = [];

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductLoading());

      try {
        products = await repository.getProducts();

        emit(ProductLoaded(List.from(products)));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<AddProductEvent>((event, emit) async {
      try {
        await repository.addProduct(event.product);

        products.insert(0, event.product);

        emit(ProductLoaded(List.from(products)));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<UpdateProductEvent>((event, emit) async {
      try {
        await repository.updateProduct(event.product);

        int index = products.indexWhere(
          (element) => element.id == event.product.id,
        );

        if (index != -1) {
          products[index] = event.product;
        }

        emit(ProductLoaded(List.from(products)));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      try {
        await repository.deleteProduct(event.id);

        products.removeWhere(
          (element) => element.id == event.id,
        );

        emit(ProductLoaded(List.from(products)));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
