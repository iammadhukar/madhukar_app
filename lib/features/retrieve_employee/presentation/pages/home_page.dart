import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madhukar_app/features/retrieve_employee/presentation/bloc/get_data_state.dart';
import 'package:madhukar_app/features/retrieve_employee/presentation/pages/add_emp_detail_page.dart';

import '../bloc/get_data_bloc.dart';
import '../widgets/emp_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        title: const Text("Employee List"),
        backgroundColor: const Color(0xff1DA1F2),
      ),
      body: BlocBuilder<GetEmpDataBloc, GetDataState>(
        builder: (context, state) {
          if (state is DataLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DataFailedState) {
            return Center(
              child: Text(state.error!),
            );
          } else {
            return state.data!.isNotEmpty
                ? ListView.separated(
                    itemCount: state.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return EmpListTile(
                        employee: state.data![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                      );
                    },
                  )
                : Center(
                    child: Image.asset(
                      "assets/images/emp_not_found.png",
                      height: 244.38,
                      width: 261.79,
                    ),
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEmployeeDetailPage()));
        },
        child: Image.asset("assets/images/fab_icon.png"),
      ),
    );
  }
}
