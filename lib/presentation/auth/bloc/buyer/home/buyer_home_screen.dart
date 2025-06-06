import 'package:canary_template/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_bloc.dart';
import 'package:canary_template/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  @override
  void initState(){
    super.initState();
    context.read<GetBurungTersediaBloc>().add(GetAllBurungTersediaEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}