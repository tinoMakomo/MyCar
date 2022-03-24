import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/home.dart';


class loginPage extends StatefulWidget {
  @override
  loginPageState createState() => loginPageState();
}

class loginPageState extends State<loginPage> {

  var overlayLoader;
  showLoader(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    overlayLoader = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withOpacity(0.4),
        child: const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
    );
    overlayState?.insert(overlayLoader);
  }

  dismissLoader() {
    try {
      setState(() {
        isLoading = false;
      });
      overlayLoader.remove();
    } catch (ex) {}
  }

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKeyLogin = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String retrievedPassword = "";
  var error;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    if (isLoading == true) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.9),
            body: Form(
                // autovalidateMode: _autoValidate,
                key: _formKeyLogin,
                child: Center(
                  child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            height: MediaQuery.of(context).size.height * 0.27,
                            width: MediaQuery.of(context).size.width * 0.55,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.perm_identity,
                                color: Colors.indigo[900],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0)),
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: 45,
                                child: TextFormField(
                                  // keyboardType: TextInputType.number,
                                  // maxLength: 10,

                                  controller: _controller2,

                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide:
                                          const BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      hintText: "Username",
                                      hintStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.lock,
                                color: Colors.indigo[900],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0)),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: _controller,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide:
                                          const BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      hintText: "password",
                                      hintStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.73,
                              height:40,
                              child: FlatButton(
                                  color: Colors.indigo[900],
                                  onPressed: signIn,
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    textAlign: TextAlign.left,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.0),
                                      side:
                                      const BorderSide(color: Colors.transparent)))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          FlatButton(
                            onPressed: () {
                              showDialog(context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text('Retrieve Your Password',style: TextStyle(color: Colors.red[900],fontSize:12,fontWeight: FontWeight.w600),),
                                      content: SizedBox(
                                        width: 350,
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            TextFormField(
                                              controller: _controller3,

                                              decoration: InputDecoration(
                                                hintText: 'username',
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                    MediaQuery.of(context).size.width *
                                                        0.03),
                                              ),

                                            ),

                                          ],
                                        ),
                                      ),
                                      actions: const <Widget>[

                                      ],
                                    );
                                  }
                              );


                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 11,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          TextButton(
                            onPressed: () {

                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      )),
                ))));
  }

  signIn() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    if (_controller2.text != '' && _controller.text != '') {
      try {
        setState(() {
          isLoading = true;
        });

        showLoader(context);
        await auth.signInWithEmailAndPassword(
            email: _controller2.text.split(" ").join("") + '@vorbis.com',
            password: _controller.text);

        dismissLoader();
        _formKeyLogin.currentState?.reset();
        //await Navigator.of(context)
            //.pushNamedAndRemoveUntil('/four', (Route<dynamic> route) => false);
      } catch (e) {
        dismissLoader();
        if (e.toString() ==
            'PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)') {
          error = 'Wrong password';
        } else if (e.toString() ==
            'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)') {
          error = 'Account does not exist';
        }  else if (e.toString() ==
            'PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)') {
          error = 'Username incorrect';
        }


        else {
          error = 'No internet Connection';
        }
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                //title: Icon(Icons.warning),
                content: Text(error),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'))
                ],
              );
            });
      }
    } else {
     // fill in required details error
    }
  }
}
