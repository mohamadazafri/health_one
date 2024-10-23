import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:health_one/dashboard/diagnose/gpt.dart';
import 'package:health_one/dashboard/diagnose/widget/identifySickness.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    // id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
    id: '8000',
  );

  final gpt = const types.User(
    // id: '82091008-a484-4a89-ae75-a22bf8d6f3a7',
    id: '8001',
  );

  @override
  void initState() {
    super.initState();
    // _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    List chatHistory = List.generate(_messages.length, (index) {
      String role;
      if (_messages[index].author.id == "8000") {
        role = "user";
      } else {
        role = "assistant";
      }

      return {
        'role': role,
        'content': _messages[_messages.length - (index + 1)].toJson()["text"],
      };
    });
    dynamic response = await chatGPT4Model(chatHistory);

    final gptMessage = types.TextMessage(
      author: gpt,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: response["choices"][0]["message"]["content"],
    );

    _addMessage(gptMessage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => IdentifySicknessPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffDBCBD8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [],
                            ),
                            const Text('Visual Diagnose', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff9AD4D6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [],
                          ),
                          const Text('Nearby Hospital', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Chat(
              messages: _messages,
              // onAttachmentPressed: _handleAttachmentPressed,
              // onMessageTap: _handleMessageTap,
              onPreviewDataFetched: _handlePreviewDataFetched,
              onSendPressed: _handleSendPressed,
              showUserAvatars: true,
              showUserNames: true,
              user: _user,
            ),
          ),
        ],
      ),
    );
  }
}
