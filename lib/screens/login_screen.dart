import 'package:flutter/material.dart';
import 'package:my_contacts_app/screens/homepage.dart';
import 'package:my_contacts_app/screens/signup_screen.dart';
import 'package:my_contacts_app/widgets/snackbar.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../auth/auth.dart';
import '../widgets/text_filed_inputs.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void navigateToSignUpScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'login Successful') {
      showSnackBar(context, 'Logged in Successfully');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      showSnackBar(context, 'Invalid Login Credentials');
    }
    setState(() {
      _isLoading = false;
    });
  }

  // void googleLogin() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String res = await AuthMethods().loginUser(
  //       email: _emailController.text, password: _passwordController.text);
  //
  //   if (res == 'Google login successful') {
  //     showSnackBar(context, 'Logged in Successfully');
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const HomePage(),
  //       ),
  //     );
  //   } else {
  //     showSnackBar(context, 'Invalid Login Credentials');
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white70, Colors.deepPurpleAccent],
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),

                Container(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.grandstander(
                            fontSize: 40, color: Colors.black),
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Welcome',
                          ),
                          TextSpan(
                            text: '\nBack',
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 64,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldInput(
                        textEditingController: _emailController,
                        hintText: 'Enter email',
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'email should not be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter password',
                  textInputType: TextInputType.text,
                  isPass: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password should not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 44,
                ),
                Material(
                  borderRadius: BorderRadius.circular(34),
                  elevation: 7,
                  child: InkWell(
                    onTap: loginUser,
                    child: Container(
                      width: 250,
                      height: 55,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          'Login',
                          style: GoogleFonts.ubuntu(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Or',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),

                // InkWell(
                //   onTap: () {
                //     AuthMethods().continueWithGoogle(context).then((value) => {
                //           if (value == "Google login successful") {loginUser}
                //         });
                //   },
                //   child: Material(
                //     elevation: 7,
                //     borderRadius: BorderRadius.circular(34),
                //     child: Container(
                //       width: 250,
                //       height: 55,
                //       alignment: Alignment.center,
                //       padding: const EdgeInsets.symmetric(vertical: 12),
                //       decoration: const ShapeDecoration(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(4),
                //           ),
                //         ),
                //         // color: Colors.deepPurpleAccent
                //       ),
                //       child: Center(
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             const CircleAvatar(
                //               radius: 10,
                //               backgroundImage: NetworkImage(
                //                 'https://w7.pngwing.com/pngs/543/934/png-transparent-google-app-logo-google-logo-g-suite-google-text-logo-circle.png',
                //               ),
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Text(
                //               'Continue with google',
                //               style: GoogleFonts.ubuntu(fontSize: 15),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                SizedBox(
                  width: 200,
                  height: 60,
                  child: SignInButton(
                    elevation: 5,
                    Buttons.Google,
                    onPressed: () {
                      AuthMethods()
                          .continueWithGoogle(context)
                          .then((value) => {
                                if (value == "Google login successful")
                                  {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage(),
                                      ),
                                    ),
                                  }
                              });
                    },
                  ),
                ),

                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: navigateToSignUpScreen,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          " Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
