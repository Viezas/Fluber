import 'dart:io';
import 'dart:typed_data';

import 'package:efrei2023gr3/constante.dart';
import 'package:efrei2023gr3/controller/firestoreHelper.dart';
import 'package:efrei2023gr3/view/my_background.dart';
import 'package:efrei2023gr3/view/my_google_maps.dart';
import 'package:efrei2023gr3/view/my_liste_personne.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  String nom;
  String prenom;
  DashBoard({required this.nom, required this.prenom,super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  //variables
  Uint8List? bytesImgages;
  String? nameImage;
  int selectedIndex = 0;


  //méthode

  selectImage(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          if(Platform.isIOS){
            return CupertinoAlertDialog(
              title: const Text("Souhaitez vous enregistrer cette image"),
              content: Image.memory(bytesImgages!),
              actions: [
                TextButton(
                    onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("Annulation")
                ),
                TextButton(
                    onPressed: (){
                      //notre entregsitrement dans la base de donnée
                      FirestoreHelper().stockageFiles(nameImage!, bytesImgages!, "Images", Moi.uid).then((value) {
                        setState(() {
                          Moi.avatar = value;
                        });
                        Map<String,dynamic> data = {
                          "AVATAR":Moi.avatar
                        };
                        FirestoreHelper().updateUser(Moi.uid, data);


                      });
                  Navigator.pop(context);
                }, child: const Text("Enregistrement")
                ),
              ],
            );
          }
          else
            {
              return AlertDialog(
                title: const Text("Souhaitez vous enregistrer cette image"),
                content: Image.memory(bytesImgages!),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text("Annulation")
                  ),
                  TextButton(
                      onPressed: (){
                        //notre entregsitrement dans la base de donnée
                        FirestoreHelper().stockageFiles(nameImage!, bytesImgages!, "Images", Moi.uid).then((value) {
                          setState(() {
                            Moi.avatar = value;
                          });
                          Map<String,dynamic> data = {
                            "AVATAR":Moi.avatar
                          };
                          FirestoreHelper().updateUser(Moi.uid, data);


                        });

                        Navigator.pop(context);
                      }, child: const Text("Enregistrement")
                  ),
                ],

              );
            }
        }
    );
  }
  pickImage() async{
    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image
    );
    if(resultat != null){
      bytesImgages = resultat.files.first.bytes;
      nameImage = resultat.files.first.name;
      selectImage();
    }
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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          MyBackground(),
          Center(child: bodyPage()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          setState(() {
            selectedIndex = value;
          });
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Personnes",
            icon: Icon(Icons.person)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
            label: "Cartes",

          )
        ],
      ),
    );
  }

  Widget bodyPage(){
    switch(selectedIndex){
      case 0 : return MyListePersonne();
      case 1 : return MyGoogleMaps();
      default: return Text("Impossible");
    }
  }
}