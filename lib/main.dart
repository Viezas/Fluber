import 'package:efrei2023gr3/controller/firestoreHelper.dart';
import 'package:efrei2023gr3/controller/permissionPhoto.dart';
import 'package:efrei2023gr3/view/myDashBoard.dart';
import 'package:efrei2023gr3/view/my_animation.dart';
import 'package:efrei2023gr3/view/my_background.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constante.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PermissionPhoto().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variable
  String nom="";
  TextEditingController prenom = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  //méhode
    popErreur(){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context){
            return AlertDialog(
              title: const Text("Erreur"),
              content: const Text("adressse ou Mot de passe incorrecte"),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")
                )
              ],
            );
          }
      );
    }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,


      ),
      extendBodyBehindAppBar: true,
      body:Stack(
        children: [
          const MyBackground(),
          Padding(
              padding: const EdgeInsets.all(10),
            child: Flexible(
              child: Column(
                children: [
                  //image
                  MyAnimation(
                    duree: 1,
                      child: Image.network("https://c.wallhere.com/photos/48/64/manga-1351619.jpg!d")),
                  //afficher le nom
                  const SizedBox(height: 10),
                  MyAnimation(
                    duree: 2,
                    child: TextField(
                      onChanged: (text){
                        setState(() {
                          nom = text;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: "Entrer votre nom",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
              
                    ),
                  ),
                  //afficher le prénom
                  const SizedBox(height: 10),
                  MyAnimation(
                    duree: 3,
                    child: TextField(
                      controller: prenom,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Entrer votre prénom",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
              
                    ),
                  ),
                  //afficher le mail
                  const SizedBox(height: 10),
                  MyAnimation(
                    duree: 4,
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          hintText: "Entrer votre mail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
              
                    ),
                  ),
                  //afficher le password
                  const SizedBox(height: 10),
                  MyAnimation(
                    duree: 5,
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Entrer votre password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
              
                    ),
                  ),
                  const SizedBox(height: 10),
                  //afficher le bouton inscription
                  MyAnimation(
                    duree: 6,
                    child: ElevatedButton(
                        onPressed: (){
                          print("j'ai appuyé");
                          FirestoreHelper().RegisterMyUser(nom, prenom.text, email.text, password.text)
                              .then((value){
                                setState(() {
                                  Moi = value;
                                });
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context){
                                      return DashBoard(nom: nom,prenom: prenom.text,);
                                    }
                                ));
                          })
                          .catchError((error){
                            //afficher un pop
                          });
              
                        },
                        child: Text("Inscription")
                    ),
                  ),
                  const SizedBox(height: 10),
              
                  MyAnimation(
                    duree: 7,
                    child: ElevatedButton(
                        onPressed: (){
                          print("j'ai appuyé");
                          FirestoreHelper().ConnectMyUser(email.text, password.text)
                              .then((value){
                            setState(() {
                              Moi = value;
                            });
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return DashBoard(nom: nom,prenom: prenom.text,);
                                }
                            ));
                          })
                              .catchError((error){
                            //afficher un pop
                            popErreur();
                          });
              
                        },
                        child: Text("Connexion")
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )

    );
  }
}








