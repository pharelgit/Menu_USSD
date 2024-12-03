import 'package:flutter/material.dart';

class CheckBalancePage extends StatefulWidget {
  const CheckBalancePage({super.key});

  @override
  State<CheckBalancePage> createState() => _CheckBalancePageState();
}

class _CheckBalancePageState extends State<CheckBalancePage> {
  bool _showBalance = false; // Variable pour contrôler l'affichage du solde

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.account_balance_wallet, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            'Afficher le solde',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Bouton Exécuter
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showBalance = true; // Affiche le solde
              });
            },
            child: const Text('Exécuter'),
          ),

          const SizedBox(height: 20),

          // Affichage du solde en bleu si le bouton est pressé
          if (_showBalance)
            const Text(
              'Montant : 10 500 Fcfa',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue, // Texte en bleu
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
