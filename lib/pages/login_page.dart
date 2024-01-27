import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:startertemplate/main_page.dart';
import 'package:startertemplate/services/auth_service.dart';
import '../components/my_login_button.dart';
import '../components/my_square_tile.dart';
import '../components/my_textfield.dart';

/*

L O G I N P A G E

This is the LoginPage, the first page the user will see based off what was configured in the main.dart file.
This is a minimal aesthetic design, but feel free to decorate it to fit your app.

When considering loggin users into your app, you must consider AUTHENTICATION:

- email sign in
- google sign in
- apple sign in
- facebook sign in, etc

There are many authentication services including firebase. This is highly dependent on your needs.

Once the user is authenticated, they are directed to the homepage.

*/

class LoginPage extends StatefulWidget {
  
  const LoginPage({super.key, required this.onTap});
final Function()? onTap;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  Future<void> signUserIn() async {

    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: usernameController.text, password: passwordController.text);
     Navigator.pop(context);
  } on FirebaseAuthException catch (e){
     Navigator.pop(context);
     print(e.code);
    if(e.code== 'user-not-found' || e.code== 'wrong-pasword' || e.code== 'invalid-credential'){
      wrongDataAuth();
    }


  }
   
    // once user is authenticated, direct them to the main page
   /* Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );*/
  }
  void wrongDataAuth(){
    showDialog(context: context, builder: (context){
     return  AlertDialog(
        title: Text('Datos incorrectos'),
      );
    });
  }

  void  doSomething(){
    print("tocado");
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.grey[900],
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  buttonText: "Ingresar",
                  onTap: signUserIn,
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png',
                    onTap: () => AuthService().signInWithgoogle(),
                    ),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png',
                    onTap: () {
                      
                    },)
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No eres miembo?',
                    style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4,),
                    GestureDetector(
onTap: widget.onTap,
                      child: const Text('Registrarse',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
