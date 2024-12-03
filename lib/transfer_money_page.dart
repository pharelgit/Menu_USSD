import 'package:flutter/material.dart';

class TransferMoneyPage extends StatefulWidget {
  const TransferMoneyPage({super.key});

  @override
  State<TransferMoneyPage> createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  void _confirmTransfer() {
    final String phoneNumber = _phoneController.text;
    final String amount = _amountController.text;
    final String code = _codeController.text;

    if (phoneNumber.isEmpty || amount.isEmpty || code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmer le transfert'),
          content: Text(
              'Transférer $amount FCFA au numéro $phoneNumber ?\nCode fourni : $code'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Transfert effectué avec succès !'),
                    backgroundColor: Colors.green,
                  ),
                );
                _clearFields();
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  void _clearFields() {
    _phoneController.clear();
    _amountController.clear();
    _codeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              'Transfert d\'argent',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          // Champ pour le numéro de téléphone
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Numéro de téléphone du destinataire',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/togo.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  const Text('+228'),
                ],
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          // Champ pour le montant
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
              labelText: 'Montant à transférer (FCFA)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: const Icon(Icons.money, color: Colors.green),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          // Champ pour le code secret
          TextField(
            controller: _codeController,
            decoration: InputDecoration(
              labelText: 'Code secret',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: const Icon(Icons.lock, color: Colors.blue),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _confirmTransfer,
            icon: const Icon(Icons.send),
            label: const Text(
              'Valider',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
