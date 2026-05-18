import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../data/model/product_model.dart';

class AddEditProductScreen extends StatefulWidget {
  final ProductModel? product;

  const AddEditProductScreen({
    super.key,
    this.product,
  });

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.product?.title ?? '',
    );

    priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );

    imageController = TextEditingController(
      text: widget.product?.image ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.product == null ? 'Add Product' : 'Edit Product',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              hint: 'Product Title',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: priceController,
              hint: 'Price',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: imageController,
              hint: 'Image URL',
            ),
            const SizedBox(height: 35),
            CustomButton(
              onTap: () {
                final product = ProductModel(
                  id: widget.product?.id ??
                      DateTime.now().millisecondsSinceEpoch,
                  title: titleController.text,
                  price: double.tryParse(priceController.text) ?? 0,
                  image: imageController.text,
                );

                if (widget.product == null) {
                  context.read<ProductBloc>().add(
                        AddProductEvent(product),
                      );
                } else {
                  context.read<ProductBloc>().add(
                        UpdateProductEvent(product),
                      );
                }

                Navigator.pop(context);
              },
              text: widget.product == null ? 'Add Product' : 'Update Product',
            )
          ],
        ),
      ),
    );
  }
}
