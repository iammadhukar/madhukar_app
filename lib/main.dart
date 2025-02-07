import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madhukar_app/features/retrieve_employee/presentation/bloc/get_data_bloc.dart';

import 'config/util/theme_data.dart';
import 'features/retrieve_employee/presentation/bloc/get_data_event.dart';
import 'features/retrieve_employee/presentation/pages/home_page.dart';
import 'injection_container.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<GetEmpDataBloc>(
              create: (context) => sl()..add(const GetEmpDataEvent()))
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme(),
          home: const HomePage(),
        ));
  }
}
