import 'package:flutter/material.dart';
import 'package:startertemplate/pages/login_page.dart';
import 'package:startertemplate/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({ Key? key }) : super(key: key);

  @override
  _LoginOrRegisterPageState createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage= true;
  void togglePages(){
    print("tofffffcado");
    setState((){
      showLoginPage= !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    
      if (showLoginPage){
        return LoginPage(
          onTap: togglePages,
        ); 
      }else{
        return RegisterPage(
          onTap: togglePages,
        );
      }
      
    
  }
}