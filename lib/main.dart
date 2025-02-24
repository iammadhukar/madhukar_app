import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/util/theme_data.dart';
import 'features/retrieve_employee/presentation/bloc/employee_data_bloc.dart';
import 'features/retrieve_employee/presentation/bloc/employee_data_event.dart';
import 'features/retrieve_employee/presentation/pages/home_page.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeDatabloc>(
              create: (context) =>
                  sl<EmployeeDatabloc>()..add(const GetEmployeeDataEvent())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme(),
          home: const HomePage(),
        ));
  }
}
