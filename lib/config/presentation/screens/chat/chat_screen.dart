import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/config/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/config/presentation/widgets/chat/her_message_buble.dart';
import 'package:yes_no_app/config/presentation/widgets/chat/my_messager_bubble.dart';
import 'package:yes_no_app/config/presentation/widgets/chat/shared/message_fieldbox.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeQBaTyz1FA1AkN_5jrDJJtolw54pZH1EfjA&usqp=CAU"),
          ),
        ),
        title: const Text("Nore... ❤"),
        backgroundColor: colors.tertiaryContainer,

        // centerTitle: true,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messageList.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messageList[index];
                    return (message.fromWho == FromWho.hers)
                        ? HerMessageBubble(
                            message: message,
                          )
                        : MyMessageBubble(
                            message: message,
                          );
                  })),

          //Input de texto
          MessageFieldBox(onValue: (value) => chatProvider.senMessage(value)),
          // onValue: chatProvider.senMessage)
        ],
      ),
    ));
  }
}
