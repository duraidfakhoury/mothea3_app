import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mothea3_app/core/core_components/app_button.dart';
import 'package:mothea3_app/core/core_components/app_text_form_field.dart';
import 'package:mothea3_app/core/core_components/return_button.dart';
import 'package:mothea3_app/core/core_components/show_snack_bar.dart';
import 'package:mothea3_app/core/enums/auth_status.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/app_validator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/auth/domain/entity/register_response.dart';
import 'package:mothea3_app/modules/auth/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:mothea3_app/modules/auth/presentation/routes/login_route.dart';
import 'package:mothea3_app/modules/home/presentation/routes/home_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final firstNameFormKey = GlobalKey<FormState>();
  final lastNameFormKey = GlobalKey<FormState>();
  final userNameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, BaseState<RegisterResponse>>(
        listener: _registerListener,
        builder: (context, state) {
          return Scaffold(
            body: AbsorbPointer(
              absorbing: state.isLoading,
              child: SizedBox(
                height: 100.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 7.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ReturnButton(
                              onTap: () => context.go(LoginRoute.name),
                            ),
                            Text(
                              LocaleKeys.registerYourAccountWithMothea3.tr(),
                              style: Theme.of(
                                context,
                              ).textTheme.headlineLarge?.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        AppTextFormField(
                          label: LocaleKeys.firstName.tr(),
                          hint: LocaleKeys.enterYourFirstName.tr(),
                          keyboardType: TextInputType.name,
                          validator: AppValidator().freeNameValidator,
                          formKey: firstNameFormKey,
                          controller: firstNameController,
                        ),
                        SizedBox(height: 1.h),
                        AppTextFormField(
                          label: LocaleKeys.lastName.tr(),
                          hint: LocaleKeys.enterYourLastName.tr(),
                          keyboardType: TextInputType.name,
                          validator: AppValidator().freeNameValidator,
                          formKey: lastNameFormKey,
                          controller: lastNameController,
                        ),
                        SizedBox(height: 1.h),
                        AppTextFormField(
                          label: LocaleKeys.userName.tr(),
                          hint: LocaleKeys.enterYourUserName.tr(),
                          keyboardType: TextInputType.name,
                          validator: AppValidator().freeNameValidator,
                          formKey: userNameFormKey,
                          controller: userNameController,
                        ),
                        SizedBox(height: 1.h),
                        AppTextFormField(
                          label: LocaleKeys.email.tr(),
                          hint: LocaleKeys.enterYourEmail.tr(),
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidator().emailValidator,
                          formKey: emailFormKey,
                          controller: emailController,
                        ),
                        SizedBox(height: 1.h),
                        AppTextFormField(
                          label: LocaleKeys.password.tr(),
                          hint: LocaleKeys.enterPassword.tr(),
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidator().passwordValidator,
                          formKey: passwordFormKey,
                          controller: passwordController,
                          isPass: true,
                        ),
                        SizedBox(height: 1.h),
                        AppTextFormField(
                          label: LocaleKeys.confrimPassword.tr(),
                          hint: LocaleKeys.reEnterYourPasswordforConfirmation
                              .tr(),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              AppValidator().confirmPasswordValidator(
                                value,
                                passwordController.text,
                              ),
                          formKey: confirmPasswordFormKey,
                          controller: confirmPasswordController,
                          isPass: true,
                        ),
                        SizedBox(height: 1.h),
                        AppButton(
                          isLoading: state.isLoading,

                          label: LocaleKeys.register.tr(),
                          onTap: () => _registerPressed(context, state),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool _checkInvalid(BaseState<void> state) {
    return !AppValidator().checkValidateFormsKeys(
      forms: [
        firstNameFormKey,
        lastNameFormKey,
        userNameFormKey,
        emailFormKey,
        passwordFormKey,
        confirmPasswordFormKey,
      ],
      successCases: [!state.isLoading],
    );
  }

  void _registerPressed(
    BuildContext context,
    BaseState<RegisterResponse> state,
  ) {
    if (_checkInvalid(state)) return;
    context.read<RegisterBloc>().add(
      RegisterTappedEvent(
        password: passwordController.text,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: userNameController.text,
      ),
    );
  }

  void _registerListener(
    BuildContext context,
    BaseState<RegisterResponse> state,
  ) {
    if (state.isError) {
      showSnackBar(context, failure: state.failure, checkFailureType: false);
      return;
    }
    Logger().d(state.data ?? 'null');

    if (state.isSuccess && state.data != null) {
      context.go(HomeRoute.name);
      showSnackBar(context, successMessage: "Welcome Back");
      return;
    }
  }
}
