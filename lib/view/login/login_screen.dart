import 'package:firebase/controller/provider/auth_provider.dart';
import 'package:firebase/view/core/space.dart';
import 'package:firebase/view/core/style.dart';
import 'package:firebase/view/login/widgets/text_form_field.dart';
import 'package:firebase/view/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In Account"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://cdn.dribbble.com/users/528264/screenshots/3140440/firebase_logo.png",
                    height: 150,
                  ),
                  const Text(
                    "Firebase",
                    style: textStyel1Bold,
                  ),
                  const Text(
                    'Authentication',
                    style: textStyel1,
                  ),
                  hight30,
                  TextFormFieldCustom(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    labelText: 'E-mail',
                  ),
                  hight10,
                  TextFormFieldCustom(
                    keyboardType: TextInputType.visiblePassword,
                    controller: password,
                    obscureText: true,
                    labelText: 'Password',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ));
                        },
                        child: const Text(
                          "Register",
                          style: textStyel,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password",
                          style: textStyel,
                        ),
                      ),
                    ],
                  ),
                  if (provider.isLoading)
                    const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  if (!provider.isLoading)
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.signInPressed(
                            email.text,
                            password.text,
                            context,
                          );
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(
                            0,
                          ),
                        ),
                        child: const Text('Sing In'),
                      ),
                    ),
                  hight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: (size / 2) - 40,
                        child: const Divider(),
                      ),
                      const Text(
                        'Or',
                        style: textStyel,
                      ),
                      SizedBox(
                        width: (size / 2) - 40,
                        child: const Divider(),
                      ),
                    ],
                  ),
                  hight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          provider.googleSignInPressed(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[200],
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Image.network(
                                'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png',
                                width: 30,
                              ),
                              hight10,
                              const Text(
                                'Sign in with Google',
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.appleSignInPressed(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.grey,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Image.network(
                                'https://1000logos.net/wp-content/uploads/2016/10/Apple_logo_grey.png',
                                width: 50,
                              ),
                              hight10,
                              const Text(
                                'Sign in with Apple',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
