import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubeclone/screens/auth/pages/sign_up_screen.dart';

import '../../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../components/text_field.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if(state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
        } else if(state is SignInLoading) {
          setState(() {
            signInRequired = true;
          });
        } else if(state is SignInFailure) {
          setState(() {
            signInRequired = false;
            _errorMsg = 'Invalid email or password';
          });
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navKey,
          home: Scaffold(
              backgroundColor:Colors.black,
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height / 3,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            scale: 8,
                          ),
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(top:size.height/4),
                        child: Container(
                          width: double.infinity,
                          height: size.height-(size.height/4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:36.0),
                            child: Column(
                              children: [
                                Container(
                                  width: size.width*0.8,
                                  child: const Text(
                                    "Login",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height/200,
                                ),
                                Container(
                                  width: size.width*0.8,
                                  child: Text(
                                    "Login to an existing account",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade500
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height/7,
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: size.width * 0.9,
                                            child: MyTextField(
                                                controller: emailController,
                                                hintText: 'Email',
                                                obscureText: false,
                                                keyboardType: TextInputType.emailAddress,
                                                prefixIcon: const Icon(CupertinoIcons.mail_solid),
                                                errorMsg: _errorMsg,
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return 'Please fill in this field';
                                                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                                                    return 'Please enter a valid email';
                                                  }
                                                  return null;
                                                }
                                            )
                                        ),
                                        SizedBox(height:size.height/40),
                                        SizedBox(
                                          width: size.width * 0.9,
                                          child: MyTextField(
                                            controller: passwordController,
                                            hintText: 'Password',
                                            obscureText: obscurePassword,
                                            keyboardType: TextInputType.visiblePassword,
                                            prefixIcon: const Icon(CupertinoIcons.lock_fill),
                                            errorMsg: _errorMsg,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return 'Please fill in this field';
                                              } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                                                return 'Please enter a valid password';
                                              }
                                              return null;
                                            },
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscurePassword = !obscurePassword;
                                                  if(obscurePassword) {
                                                    iconPassword = CupertinoIcons.eye_fill;
                                                  } else {
                                                    iconPassword = CupertinoIcons.eye_slash_fill;
                                                  }
                                                });
                                              },
                                              icon: Icon(iconPassword),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height/7),
                                        !signInRequired?
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          child: TextButton(
                                              onPressed: () {
                                                if (_formKey.currentState!.validate()) {
                                                  context.read<SignInBloc>().add(
                                                    SignInRequired(
                                                      emailController.text,
                                                      passwordController.text
                                                    )
                                                  );
                                                }
                                              },
                                              style: TextButton.styleFrom(
                                                  elevation: 3.0,
                                                  backgroundColor: Colors.grey.shade300,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(60)
                                                  )
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                                child: Text(
                                                  'Login',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              )
                                          ),

                                        ): CircularProgressIndicator(color: Colors.grey.shade100,),
                                        SizedBox(height: size.height/70),
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width ,
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Don't have an account? ",
                                                  style: TextStyle(
                                                      color: Colors.grey.shade400,
                                                      fontSize: 16
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    navKey.currentState?.push(
                                                        MaterialPageRoute<void>(
                                                            builder: (BuildContext context) =>
                                                                BlocProvider<SignUpBloc>(
                                                                    create: (context) => SignUpBloc(
                                                                        context.read<AuthenticationBloc>().userRepository
                                                                    ),
                                                                    child: const SignUpScreen()
                                                                )));
                                                  },
                                                  child:const Text(
                                                    "Sign Up",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
