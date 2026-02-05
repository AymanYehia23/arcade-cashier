import 'package:arcade_cashier/src/features/authentication/presentation/auth_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:arcade_cashier/src/common_widgets/responsive_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Focus nodes for better UX
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authControllerProvider.notifier)
          .signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(authControllerProvider);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.appTitle)),
      body: ResponsiveCenter(
        maxContentWidth: 400,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('assets/images/logo.png', height: 180),
                    const SizedBox(height: 24),
                    Text(
                      loc.loginTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      decoration: InputDecoration(
                        labelText: loc.emailLabel,
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.emailRequired;
                        }
                        return null;
                      },
                      onEditingComplete: () => FocusScope.of(
                        context,
                      ).requestFocus(_passwordFocusNode),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      decoration: InputDecoration(
                        labelText: loc.passwordLabel,
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.passwordRequired;
                        }
                        return null;
                      },
                      onEditingComplete: _submit,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: state.isLoading ? null : _submit,
                        child: state.isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : Text(loc.loginButton),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
