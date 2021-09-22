import '/models/failure.dart';
import '/repositories/auth/auth_repo.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/show_message.dart';
import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String adminUid = '8QCiBY9OksOySXOyY8wkk8UMLEv2';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) {
        return LoginScreen();
      },
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _email;
  String? _password;

  bool _hidePassword = true;
  bool _isLoading = false;

  void _login() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        setState(() {
          _isLoading = true;
        });
        final _authRepo = context.read<AuthRepository>();
        final user = await _authRepo.logInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
        if (user?.uid != null) {
          setState(() {
            _isLoading = false;
          });
          ShowMessage.showSuccussMessage(context,
              message: 'Successful, Welcome to the console !');
        }
      }
    } on Failure catch (error) {
      print('Error Login ${error.toString()}');
      setState(() {
        _isLoading = false;
      });
      ShowMessage.showErrorMessage(context, message: error.message);
    } catch (error) {
      print('Error Login ${error.toString()}');
      setState(() {
        _isLoading = false;
      });
      ShowMessage.showErrorMessage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Admin Login'),
          centerTitle: true,
          //  backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        ),
        body: _isLoading
            ? LoadingIndicator()
            : ResponsiveBuilder(
                builder: (_, size) {
                  return Center(
                    child: Card(
                      margin: size.isDesktop
                          ? EdgeInsets.all(130)
                          : EdgeInsets.all(20.0),
                      elevation: 10.0,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 40.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0,
                                  vertical: 15.0,
                                ),
                                child: TextFormField(
                                  key: ValueKey('email'),
                                  onSaved: (value) => _email = value,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) =>
                                      !(value!.contains('@gmail.com'))
                                          ? 'Invalid Email'
                                          : null,
                                  decoration: InputDecoration(
                                    //icon: Icon(Icons.mail),
                                    prefixIcon: Icon(Icons.mail),
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0,
                                  vertical: 15.0,
                                ),
                                child: TextFormField(
                                  key: ValueKey('password'),
                                  onSaved: (value) => _password = value,
                                  obscureText: _hidePassword,
                                  validator: (value) => value!.length < 6
                                      ? 'Password too short'
                                      : null,
                                  decoration: InputDecoration(
                                    // icon: Icon(Icons.lock),
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _hidePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      },
                                    ),
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25.0),
                              if (_isLoading) CircularProgressIndicator(),
                              if (!_isLoading)
                                ElevatedButton(
                                  // style: ButtonStyle(
                                  //   backgroundColor:
                                  //       MaterialStateProperty.all<Color>(
                                  //     Color.fromRGBO(0, 141, 82, 1),
                                  //   ),
                                  // ),
                                  onPressed: _login,
                                  //  _adminLogin(context);

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0, vertical: 10.0),
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(height: 40.0),
                              // if (!_isLoading)
                              //   TextButton(
                              //     onPressed: () {
                              //       // Navigator.pushNamed(
                              //       //     context, LoginUserScreen.routeName);
                              //     },
                              //     child: Text('Have an account? Login'),
                              //   ),
                              // SizedBox(height: 40.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
