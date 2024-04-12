// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.onChanged});
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        color: const Color.fromARGB(255, 121, 242, 240),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
        elevation: 2,
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<HomeCubit>(context).clearFilter();
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.clear)),
            hintText: 'Search',
            border: InputBorder.none,
            hintMaxLines: 1,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
