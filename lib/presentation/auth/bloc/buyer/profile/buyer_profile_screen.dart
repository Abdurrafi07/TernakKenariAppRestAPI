import 'package:canary_template/presentation/auth/bloc/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:canary_template/presentation/auth/bloc/buyer/profile/bloc/profile_buyer_event.dart';
import 'package:canary_template/presentation/auth/bloc/buyer/profile/bloc/profile_buyer_state.dart';
import 'package:canary_template/presentation/auth/bloc/buyer/profile/profile_buyer_form.dart';
import 'package:canary_template/presentation/auth/bloc/buyer/profile/widget/profile_view_buyer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil Pembeli")),
      body: BlocListener<ProfileBuyerBloc, ProfileBuyerState>(
        listener: (context, state) {
          if (state is ProfileBuyerAdded) {
            // refresh profil setelah tambah
            context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profil berhasil ditambahkan")),
            );
          }
        },
        child: BlocBuilder<ProfileBuyerBloc, ProfileBuyerState>(
          builder: (context, state) {
            if (state is ProfileBuyerLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileBuyerLoaded && state.profile.data.name.isNotEmpty) {
              final profile = state.profile.data;
              return ProfileViewBuyer(profile: profile);
            }

            // Default ke form jika tidak ada data atau error
            return ProfileBuyerInputForm();
          },
        ),
      ),
    );
  }
}
