import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efrei2023gr3/constante.dart';
import 'package:efrei2023gr3/controller/firestoreHelper.dart';
import 'package:efrei2023gr3/model/my_user.dart';
import 'package:flutter/material.dart';

class MyListePersonne extends StatefulWidget {
  const MyListePersonne({super.key});

  @override
  State<MyListePersonne> createState() => _MyListePersonneState();
}

class _MyListePersonneState extends State<MyListePersonne> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().cloudUsers.snapshots(),
        builder: (context, snap){
          if(ConnectionState.waiting == snap.connectionState){
            return const CircularProgressIndicator.adaptive();
          }
          else
            {
              if(snap.hasData == null){
                return const Text("Aucune donnée");
              }
              else
                {
                  List documents = snap.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                      itemBuilder: (context,index){
                       MyUser otherUser = MyUser.database(documents[index]);
                       if(Moi.uid == otherUser.uid){
                         return Container();
                       }
                       else {
                         return Card(
                           elevation: 5,
                           color: Colors.amber,
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15)),
                           child: ListTile(
                             leading: CircleAvatar(
                               radius: 70,
                               backgroundImage: NetworkImage(otherUser.avatar ??
                                   imageDefault),
                             ),
                             title: Text(otherUser.fullName),
                             subtitle: Text(otherUser.email),
                             trailing: Icon(Icons.favorite_outline_outlined),
                           ),
                         );
                       }
                      }
                  );
                }

            }
        }
    );
  }
}
