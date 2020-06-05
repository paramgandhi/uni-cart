import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uni_cart/models/item.dart';
import 'package:uni_cart/models/user.dart';

/**
 * Responsible for retrieving data from Firebase and deserializing it to 
 * its appropriate class.
 */
class DatabaseService {

  final String uid; // identify current user

  DatabaseService({this.uid});

  // create collection reference for users
  final CollectionReference userCollection = Firestore.instance.collection('users');
  
  // create collection reference for items
  final CollectionReference itemCollection = Firestore.instance.collection('items');

  Future initUserData(String name, String number, String address) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'number': number,
      'address': address
    });
  }

  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Item(
        name: doc['name'] ?? 'n/a',
        author: doc['author'] ?? 'n/a', 
        key: doc.documentID.toString() ?? 'n/a'
        );
    }).toList();
  }

  Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }

  Stream

  // Future => 

  void listUserData() {
    userCollection.getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) { 
        print(result.data);
      });
    });
  }


  Future addItemToList(String name, DateTime date, String time, String note, String price, String unit,
                        String quantity) async {
    String key = UniqueKey().toString();
    return await itemCollection.document(key).setData({
      'name':name,
      'author': this.uid,
      'date': date,
      'time': time,
      'note': note,
      'price': price,
      'unit': unit,
      'quantity': quantity
    });
  }

  


}