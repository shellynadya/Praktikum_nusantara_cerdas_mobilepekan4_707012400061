import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final pesanController = TextEditingController();

  final List<Map<String, dynamic>> pesan = [
    {
      'teks': 'Selamat datang di layanan Nusantara Cerdas Mobile. Ada yang bisa dibantu?',
      'dariWarga': false,
    },
  ];

  @override
  void dispose() {
    pesanController.dispose();
    super.dispose();
  }

  void kirimPesan() {
    final teks = pesanController.text.trim();

    if (teks.isEmpty) return;

    setState(() {
      pesan.add({
        'teks': teks,
        'dariWarga': true,
      });

      pesanController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(12),
              itemCount: pesan.length,
              itemBuilder: (context, index) {
                final data =
                    pesan[pesan.length - 1 - index];

                final bool dariWarga =
                    data['dariWarga'] as bool;

                return Align(
                  alignment: dariWarga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: dariWarga
                          ? Colors.deepPurple
                          : Colors.grey[300],
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Text(
                      data['teks'] as String,
                      style: TextStyle(
                        color: dariWarga
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pesanController,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => kirimPesan(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: kirimPesan,
                  icon: const Icon(Icons.send),
                  tooltip: 'Kirim',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}