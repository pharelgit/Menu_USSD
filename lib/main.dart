import 'package:flutter/material.dart';
import 'buy_packages_page.dart'; // Votre page BuyPackagesPage
import 'check_balance_page.dart'; // Votre page CheckBalancePage
import 'transfer_money_page.dart'; // Votre page TransferMoneyPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion USSD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Informations utilisateur
  String _firstName = "Jean";
  String _lastName = "Dupont";
  String _phoneNumber = "+1234567890";
  String? _profileImagePath;

  // Liste des pages
  final List<Widget> _pages = const [
    CheckBalancePage(),
    TransferMoneyPage(),
    BuyPackagesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Méthode pour ouvrir la boîte de dialogue Profil
  void _openProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController firstNameController =
            TextEditingController(text: _firstName);
        TextEditingController lastNameController =
            TextEditingController(text: _lastName);
        TextEditingController phoneController =
            TextEditingController(text: _phoneNumber);

        return AlertDialog(
          title: const Text("Modifier le profil"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImagePath != null
                          ? AssetImage(_profileImagePath!)
                          : const AssetImage('assets/i1.jpg'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: _pickImage,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'Prénom'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Numéro de téléphone'),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _firstName = firstNameController.text;
                  _lastName = lastNameController.text;
                  _phoneNumber = phoneController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  // Méthode pour choisir une image (chemin simulé ici)
  void _pickImage() {
    setState(() {
      _profileImagePath = 'assets/i2.jpg'; // Remplacez par le chemin de l'image choisie
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _openProfileDialog,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: _profileImagePath != null
                    ? AssetImage(_profileImagePath!)
                    : const AssetImage('assets/i1.jpg'),
              ),
              const SizedBox(width: 10),
              Text(_firstName), // Affiche le prénom comme titre
            ],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Solde'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Transfert'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Forfaits'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
