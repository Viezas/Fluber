
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efrei2023gr3/constante.dart';
import 'package:efrei2023gr3/controller/firestoreHelper.dart';

class MyUser {
  //attributs
  late String uid;
  late String nom;
  late String prenom;
  late String email;
  String? avatar;
  List? favoris;

  //variable calculé
  String get fullName {
    return prenom + " " + nom;
  }

  bool isFavoris(String uid) {
    return favoris?.contains(uid) ?? false;
  }

  //constructeurs
  MyUser(){
    uid = "";
    nom = "";
    prenom = "";
    email = "";
  }

  MyUser.database(DocumentSnapshot snapshot){
      uid = snapshot.id;
      Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
      nom = map["NOM"];
      prenom = map["PRENOM"];
      email = map["EMAIL"];
      avatar = map["AVATAR"] ?? imageDefault;
      favoris = map["FAVORIS"] ?? [];
  }

  toggleFavoris(String uid) {
    bool hasFavoris = favoris!.contains(uid);

    if(hasFavoris) {
      favoris?.remove(uid);
    } else {
      favoris?.add(uid);
    }

    Map<String,dynamic> data = {
      "FAVORIS":Moi.favoris
    };

    FirestoreHelper().updateUser(Moi.uid, data);
  }
}