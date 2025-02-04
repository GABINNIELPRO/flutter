import 'package:flutter/material.dart';
import 'confirmer_transfert.dart';

class MobileMoneyPage extends StatefulWidget {
  const MobileMoneyPage({super.key});

  @override
  State<MobileMoneyPage> createState() => _MobileMoneyPageState();
}

class _MobileMoneyPageState extends State<MobileMoneyPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addNumberToPhone(String number) {
    setState(() {
      _phoneController.text += number;
    });
  }

  void _deleteLastDigit() {
    setState(() {
      if (_phoneController.text.isNotEmpty) {
        _phoneController.text = _phoneController.text.substring(0, _phoneController.text.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement Mobile Money'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Téléphone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Montant',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: 'XOF',
                    items: ['XOF', 'USD', 'EUR'].map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Frais 1% soit 120F',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index < 9) {
                  return ElevatedButton(
                    onPressed: () => _addNumberToPhone('${index + 1}'),
                    child: Text('${index + 1}'),
                  );
                } else if (index == 9) {
                  return ElevatedButton(
                    onPressed: () => _addNumberToPhone('0'),
                    child: const Text('0'),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: _deleteLastDigit,
                    child: const Icon(Icons.backspace),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmerTransfertPage(
                        phoneNumber: _phoneController.text,
                        amount: _amountController.text,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Transférer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
