import 'package:get_it/get_it.dart';
import 'package:madhukar_app/core/database/app_database.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/usecases/get_emp_data.dart';
import 'package:madhukar_app/features/retrieve_employee/presentation/bloc/employee_data_bloc.dart';

import 'features/retrieve_employee/data/data_sources/local_data/emp_database_local.dart';
import 'features/retrieve_employee/data/repository/emp_data_repository_impl.dart';
import 'features/retrieve_employee/domain/repository/emp_data_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //floor database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  //local database
  sl.registerLazySingleton<EmpDatabaseLocal>(() => EmpDatabaseLocal());

  //repository
  sl.registerLazySingleton<EmpDataRepository>(
      () => EmpDataRepositoryImpl(sl(), sl()));
  //usecases
  sl.registerLazySingleton<GetEmpDataUseCase>(() => GetEmpDataUseCase(sl()));

  //blocs
  sl.registerFactory<EmployeeDatabloc>(() => EmployeeDatabloc(sl()));
}
