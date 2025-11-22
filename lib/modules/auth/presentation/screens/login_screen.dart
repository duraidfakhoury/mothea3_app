import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mothea3_app/core/core_components/app_button.dart';
import 'package:mothea3_app/core/core_components/app_text_form_field.dart';
import 'package:mothea3_app/core/core_components/show_snack_bar.dart';
import 'package:mothea3_app/core/enums/auth_status.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/app_validator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:mothea3_app/modules/auth/presentation/routes/register_route.dart';
import 'package:mothea3_app/modules/home/presentation/routes/home_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();


    @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> sl<LoginBloc>(),
      child: BlocConsumer<LoginBloc , BaseState<AuthStatus>>(
        listener: _loginListener,
        builder: (context, state) {
          return Scaffold(
            body: AbsorbPointer(
              absorbing: state.isLoading,
              child: SizedBox(
                height: 100.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 7.w),
                    child: Column(
                      children: [
                        SizedBox(height: 17.h,),
                        Text(LocaleKeys.welcome.tr()
                        ,style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize:24 ),),
                        SizedBox(height: 10.h,),
                        AppTextFormField(
                          label: LocaleKeys.userName.tr(),
                          hint: LocaleKeys.enterYourUserName.tr(),
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidator().freeNameValidator,
                          formKey: emailFormKey,
                          controller: emailController,
                          ),
                        SizedBox(height: 2.h,),
                        AppTextFormField(
                          label: LocaleKeys.password.tr(),
                          hint: LocaleKeys.enterPassword.tr(),
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidator().passwordValidator,
                          formKey: passwordFormKey,
                          controller: passwordController,
                          isPass: true,
                          ),
                        SizedBox(height: 10.h,),
                        AppButton(label: LocaleKeys.login.tr(context: context), onTap:()=>_loginPressed(context,state) ),
                        SizedBox(height: 2.h,),
                        Text(LocaleKeys.doNotHaveAnAccount.tr()),
                        SizedBox(height: 2.h,),
                        AppButton(appButtonType: AppButtonType.unFilled, label: LocaleKeys.register.tr(), onTap: (){
                          context.go(RegisterRoute.name);
                        })
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
        emailFormKey,
        passwordFormKey,
      ],
      successCases: [!state.isLoading],
    );
  }

    void _loginPressed(BuildContext context, BaseState<AuthStatus> state) {
    if (_checkInvalid(state)) return;
    context.read<LoginBloc>().add(
          LoginTapped(
            password: passwordController.text,
            email: emailController.text,
          ),
        );
  }


    void _loginListener(BuildContext context, BaseState<AuthStatus> state) {
    if (state.isError || state.data! == AuthStatus.unAuthenticated) {
      showSnackBar(context, failure: state.failure, checkFailureType: false);
      return;
    }
    Logger().d(state.data ?? 'null');

    if (state.isSuccess && state.data! == AuthStatus.authenticated) {
      context.go(HomeRoute.name);
      showSnackBar(context,
          successMessage: "Welcome Back");
      return;
    }
    
  }
}