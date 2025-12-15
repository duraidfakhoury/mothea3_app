import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/enums/acadimic_status.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/auth/domain/entity/profile.dart';
import 'package:mothea3_app/modules/home/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String _statusText(BuildContext context, AcadimicStatus status) {
    switch (status) {
      case AcadimicStatus.beginner:
        return 'Beginner';
      case AcadimicStatus.intermediate:
        return 'Intermediate';
      case AcadimicStatus.advanced:
        return 'Advanced';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(GetUserEvent()),
      child: BlocBuilder<UserBloc, BaseState<Profile>>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellow),
                ),
              ),
            );
          }

          if (state.isError || state.data == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.profile.tr()),
                centerTitle: true,
              ),
              body: Center(
                child: Text(
                  LocaleKeys.anUnexpectedError.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          final profile = state.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.profile.tr()),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.yellow,
                    child: Text(
                      profile.userName.isNotEmpty
                          ? profile.userName[0].toUpperCase()
                          : '?',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: AppColors.white),
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    profile.userName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    profile.email,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.greyAccent,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(LocaleKeys.phoneNumber.tr()),
                      subtitle: Text(profile.number),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.school),
                      title: Text(LocaleKeys.academicYear.tr()),
                      subtitle: Text(
                        _statusText(context, profile.acadamicStatus),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
