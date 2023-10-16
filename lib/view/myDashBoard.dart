import 'package:efrei2023gr3/constante.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  String nom;
  String prenom;
  DashBoard({required this.nom, required this.prenom,super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {


  //méthode
  pickImage(){
    FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.66,
        color: Colors.white,
        child: Column(
          children: [
            //avatar

            InkWell(
              onTap: (){
                pickImage();
                print("j'ai appuyé sur l'image");
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(Moi.avatar??imageDefault),

              ),
            ),
            //nom complet
            Text(Moi.fullName),
            //mail
            ListTile(
              leading: const Icon(Icons.mail),
              title: Text(Moi.email),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Bonjour ${widget.prenom}  ${widget.nom}"),
      ),
      body: const Text("coucou"),
    );
  }
}