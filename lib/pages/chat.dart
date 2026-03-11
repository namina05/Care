import 'package:care/pages/homepage.dart';
import 'package:flutter/material.dart';
import '../service/geminiservice.dart';

const red = Color.fromARGB(255, 200, 92, 92);

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<Map<String, dynamic>> messages = [];

  bool isLoading = false;

  Future<void> sendMessage() async {

    final text = controller.text.trim();

    if (text.isEmpty || isLoading) return;

    setState(() {
      messages.add({"text": text, "isUser": true});
      isLoading = true;
    });

    controller.clear();

    final reply = await sendToGroq(text);

    setState(() {
      messages.add({"text": reply, "isUser": false});
      isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget messageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 260),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isUser ? red : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0,3),
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget typingBubble() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          "Kyra is typing...",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xfff6f6f6),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: red),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Homepage()),
            );
          },
        ),
        title: const Text(
          "Kyra",
          style: TextStyle(
            color: red,
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.only(top: 10),
              itemCount: messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {

                if (index == messages.length) {
                  return typingBubble();
                }

                final msg = messages[index];

                return messageBubble(msg["text"], msg["isUser"]);
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                )
              ]
            ),

            child: Row(
              children: [

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (_) => sendMessage(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  decoration: const BoxDecoration(
                    color: red,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: sendMessage,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}