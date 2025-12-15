import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/enums/app_languages.dart';
import 'package:mothea3_app/core/theme/bloc/theme_bloc.dart';
import 'package:mothea3_app/core/utils/app_locale.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is DarkThemeActionState;
        final currentLanguage = AppLocale().currentLanguage(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.settings.tr()),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.settings.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  color: AppColors.navy.withOpacity(0.05),
                  child: SwitchListTile(
                    title: Text(
                      LocaleKeys.changeTheme.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      isDark
                          ? LocaleKeys.darkMode.tr()
                          : LocaleKeys.lightMode.tr(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.greyAccent,
                      ),
                    ),
                    value: isDark,
                    activeColor: AppColors.yellow,
                    onChanged: (value) {
                      if (value) {
                        context.read<ThemeBloc>().add(SetDarkThemeEvent());
                      } else {
                        context.read<ThemeBloc>().add(SetLightThemeEvent());
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  color: AppColors.navy.withOpacity(0.05),
                  child: ListTile(
                    title: Text(
                      LocaleKeys.language.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      currentLanguage == AppLanguages.arabic
                          ? LocaleKeys.arabic.tr()
                          : LocaleKeys.english.tr(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.greyAccent,
                      ),
                    ),
                    trailing: DropdownButton<AppLanguages>(
                      value: currentLanguage,
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      underline: const SizedBox.shrink(),
                      items: const [
                        DropdownMenuItem(
                          value: AppLanguages.arabic,
                          child: Text('العربية'),
                        ),
                        DropdownMenuItem(
                          value: AppLanguages.english,
                          child: Text('English'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          AppLocale().changeLanguage(context, value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
