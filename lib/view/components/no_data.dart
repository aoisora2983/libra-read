import 'package:flutter/material.dart';
import 'package:libra_read/view/components/register_book_dialog.dart';

class NoData extends StatelessWidget {
  const NoData({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const RegisterBookDialog();
                      },
                    );
                  },
                  label: const Text('登録する'),
                  icon: const Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
