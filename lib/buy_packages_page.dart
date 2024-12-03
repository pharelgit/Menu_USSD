import 'package:flutter/material.dart';

class BuyPackagesPage extends StatefulWidget {
  const BuyPackagesPage({super.key});

  @override
  State<BuyPackagesPage> createState() => _BuyPackagesPageState();
}

class _BuyPackagesPageState extends State<BuyPackagesPage> {
  bool _showPackages = false; // Variable pour afficher ou masquer les forfaits

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart, size: 80, color: Colors.orange),
          const SizedBox(height: 20),
          const Text(
            'Acheter des forfaits',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Bouton pour afficher les forfaits
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showPackages = !_showPackages; // Alterne l'affichage des forfaits
              });
            },
            child: Text(_showPackages ? 'Masquer les forfaits' : 'Parcourir les forfaits'),
          ),

          const SizedBox(height: 20),

          // Affichage conditionnel des forfaits
          if (_showPackages)
            Wrap(
              spacing: 10.0, // Espacement horizontal
              runSpacing: 10.0, // Espacement vertical
              children: [
                _buildPackageButton(context, '100 Mo'),
                _buildPackageButton(context, '250 Mo'),
                _buildPackageButton(context, '500 Mo'),
                _buildPackageButton(context, '1 Go'),
                _buildPackageButton(context, '2 Go'),
                _buildPackageButton(context, '5 Go'),
              ],
            ),
        ],
      ),
    );
  }

  // Widget pour construire un bouton de forfait
  Widget _buildPackageButton(BuildContext context, String package) {
    return ElevatedButton(
      onPressed: () {
        _confirmSelection(context, package);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 203, 223, 240), // Couleur bleue pour les boutons de forfait
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Coins arrondis
        ),
      ),
      child: Text(package, style: const TextStyle(fontSize: 16)),
    );
  }

  // Méthode pour afficher une boîte de dialogue de confirmation
  void _confirmSelection(BuildContext context, String package) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('Voulez-vous vraiment acheter $package ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
                _showSnackBar(context, '$package acheté avec succès !');
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  // Méthode pour afficher un SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
