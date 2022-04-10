import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class   HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  int currentPage = 1;
  int cartItems = 1;
  var ignition;
  var dl;
  var el;
  bool signedIn = false;
  String userid = "";
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
       // isLoading = false;
      });
      overlayLoader.remove();
    } catch (ex) {}
  }

  checkButtons(){

    setState(() {
      el = true;
      dl = true;
      ignition = true;
    });
  }

  getId() async {
    if (await FirebaseAuth.instance.currentUser != null) {
      print('signed in');
      setState(() {
        signedIn = true;
        userid = FirebaseAuth.instance.currentUser!.uid;
      });
    }
    print(userid);
  }

  @override
  void initState() {
    getId();
    checkButtons();
    super.initState();
  }



  Future<bool> _willPopCallback() async {
    /*if (isLoading == true) {
      return false;
    } else {
      return true;
    }*/
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
            backgroundColor: Colors.black12/*.withOpacity(0.9)*/,
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: const Text('MyCar'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              ),
              IconButton(icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
                onPressed: () {
                  // do something
                },),
            ],

            elevation: 0.3,
          ),
          body:SingleChildScrollView(child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.35,
                  width: MediaQuery.of(context).size.width,
                    child:Image.asset('assets/images/car2.jpg')
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                        onTap: (){


                            setState(() {
                              ignition = !ignition;
                            });

                        },
                       child: Container(
                         height: 160,
                         width: 160,
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.white70),
                           borderRadius: BorderRadius.circular(15),
                         ),
                          child: Card(
                            color: ignition == true ?Colors.pink: Colors.black12,
                            elevation: 0.9,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.power_settings_new_rounded
                                    ,size: 70,color: Colors.white,
                                  ),
                                  Text('Ignition', style: TextStyle(color: Colors.white),),

                                ],
                              ),
                            ),
                          ),
                        )),

                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                dl = !dl;
                              });
                            },
                            child: Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Card(
                                color: dl == true ? Colors.pink: Colors.black12,
                                elevation: 0.9,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.lock_outline_rounded
                                        ,size: 70,color: Colors.white,
                                      ),
                                      Text('Door Lock', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],

                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                el = !el;
                              });
                            },
                            child: Container(

                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Card(

                                color: el == true ?Colors.pink: Colors.black12,
                                elevation: 0.9,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.lock_outline_rounded
                                        ,size: 70,color: Colors.white,
                                      ),
                                      Text('Engine Lock', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            )),

                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                            onTap: (){


                            },
                            child: Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Card(
                                color: Colors.black12,
                                elevation: 0.9,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.location_on_outlined
                                        ,size: 70,color: Colors.white,
                                      ),
                                      Text('location', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),

          )),
          bottomNavigationBar:  BottomAppBar(

            elevation: 0.3,
            shape: const CircularNotchedRectangle(),
            notchMargin: 12,
            color: Colors.white,
            child: SizedBox(
                height: 63,
                child:Row(
                  children: [

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 63,

                      child: Card(

                        elevation: 0,
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  currentPage = 1;
                                });
                              },
                              child:  SizedBox(
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.home
                                      ,size: 26,color: currentPage == 1? Colors.pink : Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            cartItems == 0 ?GestureDetector(
                              onTap: (){
                                setState(() {
                                  currentPage = 2;
                                });
                              },
                              child:  SizedBox(
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart
                                      ,size: 26,color: currentPage == 2? Colors.pink : Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            ):/* GestureDetector(
                                onTap: (){

                                },
                                child:SizedBox(
                                  width: 35,
                                  height: 47,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                              onPressed: () => {
                                                setState(() {
                                                  currentPage = 2;
                                                }),
                                              },
                                              icon: Icon(
                                                Icons.shopping_cart,
                                                size: 26,color: currentPage == 2? Colors.pink : Colors.black45,
                                              ))),
                                      /*Positioned(
                              top: 3,
                              right: 5,
                              child: Container(
                                width: 17,
                                height: 17,
                                child: Center(child:Text(cartItems.toString(), style: const TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold),)),
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                              ))*/
                                    ],
                                  ),
                                )),*/
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  currentPage = 3;
                                });
                              },
                              child:  SizedBox(
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.location_on
                                      ,size: 26,color: currentPage == 3? Colors.pink : Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  currentPage = 4;
                                });
                              },
                              child:  SizedBox(
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.person
                                      ,size: 26, color:currentPage == 4? Colors.pink : Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
            ));
  }
}
