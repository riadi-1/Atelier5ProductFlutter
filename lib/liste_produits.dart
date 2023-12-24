import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_2023/produit.dart';
import 'package:flutter_firebase_2023/add_produit.dart';

class ListProduits extends StatefulWidget {
  const ListProduits({Key? key}) : super(key: key);

  @override
  State<ListProduits> createState() => _ListProduitsState();
}

class _ListProduitsState extends State<ListProduits> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('produits').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Produit> produits = snapshot.data!.docs.map((doc) {
            return Produit.fromFirestore(doc);
          }).toList();

          return ListView.builder(
            itemCount: produits.length,
            itemBuilder: (context, index) => ProduitItem(
              produit: produits[index],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjoutProduitScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProduitItem extends StatelessWidget {
  ProduitItem({Key? key, required this.produit}) : super(key: key);

  final Produit produit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(produit.photo),
        ListTile(
          title: Text(produit.designation),
          subtitle: Text(produit.marque),
          trailing: Text('${produit.prix}'),
        ),
      ],
    );
  }
}
