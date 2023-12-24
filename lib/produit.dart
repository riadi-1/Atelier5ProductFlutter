import 'package:cloud_firestore/cloud_firestore.dart';

class Produit {
  String id;
  String marque;
  String designation;
  String categorie;
  double prix;
  String photo;
  int quantite;
  bool adminOnly; // Champ pour spécifier si le produit est réservé aux admins

  Produit({
    required this.id,
    required this.marque,
    required this.designation,
    required this.categorie,
    required this.prix,
    required this.photo,
    required this.quantite,
    required this.adminOnly, // Ajout du champ adminOnly
  });

  factory Produit.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Produit(
      id: doc.id,
      marque: data['marque'] ?? '',
      designation: data['designation'] ?? '',
      categorie: data['categorie'] ?? '',
      prix: (data['prix'] ?? 0.0).toDouble(),
      photo: data['photo'] ?? '',
      quantite: data['quantite'] ?? 0,
      adminOnly:
          data['adminOnly'] ?? false, // Récupération de la valeur adminOnly
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marque': marque,
      'designation': designation,
      'categorie': categorie,
      'prix': prix,
      'photo': photo,
      'quantite': quantite,
      'adminOnly': adminOnly, // Ajout du champ adminOnly
    };
  }
}
