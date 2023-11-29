//fichier qui gère les opérations sur la base de donnée

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efrei2023gr3/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreHelper {
  final auth = FirebaseAuth.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");
  final storage = FirebaseStorage.instance;

  //création d'un utilisateur
  Future<MyUser>RegisterMyUser(String nom , String prenom , String email, String password) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = credential.user!.uid;
    Map<String,dynamic> map = {
      "NOM": nom,
      "PRENOM":prenom,
      "EMAIL": email,
    };
    addUser(uid,map);
    return getUser(uid);
  }

  //récuperer les infos de l'utilisateur
  Future<MyUser> getUser(String uid) async{
    DocumentSnapshot snapshot = await cloudUsers.doc(uid).get();
    return MyUser.database(snapshot);
  }

  //ajouter dans la bdd les infos utilisateurs
  addUser(String uid, Map<String,dynamic> data){
    cloudUsers.doc(uid).set(data);
  }


  //connexion d'un utilisateur
  Future<MyUser>ConnectMyUser(String email, String password) async{
    UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
    String uid = credential.user!.uid;
    return getUser(uid);
  }

  //User log out
  Future<void>signOutMyUser() async{
    return await auth.signOut();
  }

  //suppression d'un utilisateur

  //mise à jour d'un utilisateur
  updateUser(String uid, Map<String,dynamic> data){
    cloudUsers.doc(uid).update(data);
  }

  //stockage image
  Future<String>stockageFiles(String nameImage,Uint8List bytesImage,String dossier,String uid) async {
    TaskSnapshot snapshot = await storage.ref("/$dossier/$uid/$nameImage").putData(bytesImage);
    String url = await snapshot.ref.getDownloadURL();
    return url;

  }
}
