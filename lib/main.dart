import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/product_bloc.dart';
import 'data/repository/product_repository.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const LuxoraApp());
}

class LuxoraApp extends StatelessWidget {
  const LuxoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ProductRepository(),
      child: BlocProvider(
        create: (context) => ProductBloc(
          context.read<ProductRepository>(),
        )..add(GetProductsEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Luxora',
          theme: ThemeData.dark(),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
