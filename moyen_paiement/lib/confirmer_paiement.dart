import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'mobile_money_page.dart';
import 'main.dart';
import 'reussite_paiement.dart';
class ConfirmerPaiementPage extends StatefulWidget {
  const ConfirmerPaiementPage({super.key});

  @override
  _ConfirmerPaiementPageState createState() => _ConfirmerPaiementPageState();
}

class _ConfirmerPaiementPageState extends State<ConfirmerPaiementPage> {
  String enteredCode = "";

  void _addDigit(String digit) {
    if (enteredCode.length < 4) {
      setState(() {
        enteredCode += digit;
      });
    }
  }

  void _deleteLastDigit() {
    if (enteredCode.isNotEmpty) {
      setState(() {
        enteredCode = enteredCode.substring(0, enteredCode.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Confirmer le paiement',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Total à payer',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '€ 15.00',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Soit 9791,04 FCFA',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: index < enteredCode.length ? Colors.orange : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return const SizedBox();
                  } else if (index == 11) {
                    return IconButton(
                      onPressed: _deleteLastDigit,
                      icon: const Icon(Icons.backspace_outlined, color: Colors.grey),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () => _addDigit(index == 10 ? '0' : '${index + 1}'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        index == 10 ? '0' : '${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: enteredCode.length == 4
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReussitePaiementPage(),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Confirmer le code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
