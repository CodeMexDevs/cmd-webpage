import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../services/chat_service.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  bool _isOpen = false;
  bool _isAuthenticated = false; // ADDED: State for chat authentication
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _accessCodeController = TextEditingController(); // ADDED: Controller for access code
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  String? _accessCodeError; // ADDED: To show error message for access code

  static const String _correctAccessCode = '7878'; // ADDED: Correct access code

  @override
  void dispose() {
    _messageController.dispose();
    _accessCodeController.dispose(); // ADDED
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final userMessage = _messageController.text;
    _messageController.clear();

    setState(() {
      _messages.add(ChatMessage(role: 'user', content: userMessage));
    });

    _scrollToBottom();

    try {
      final response = await _chatService.sendMessage(userMessage);
      setState(() {
        _messages.add(ChatMessage(role: 'assistant', content: response));
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          role: 'assistant',
          content: 'Error: ${e.toString()}',
        ));
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: AppConstants.defaultAnimationDuration,
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ADDED: Method to handle access code submission
  void _checkAccessCode() {
    if (_accessCodeController.text == _correctAccessCode) {
      setState(() {
        _isAuthenticated = true;
        _accessCodeError = null; // Clear any previous error
        _accessCodeController.clear(); // Clear the input field
      });
    } else {
      setState(() {
        _accessCodeError = AppStrings.invalidAccessCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: AppConstants.defaultAnimationDuration,
            curve: Curves.easeInOut,
            width: _isOpen ? 350 : 0,
            height: _isOpen ? 450 : 0,
            child: _isOpen ? _buildChatBox(theme, isDark) : null,
          ),
          FloatingActionButton(
            onPressed: () => setState(() => _isOpen = !_isOpen),
            backgroundColor: theme.colorScheme.primary,
            child: Icon(
              _isOpen ? Icons.close : Icons.chat,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBox(ThemeData theme, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(theme),
          // MODIFIED: Conditional rendering based on authentication
          _isAuthenticated
              ? Expanded(
                  child: Column(
                    children: [
                      _buildMessageList(isDark),
                      _buildInputField(theme),
                    ],
                  ),
                )
              : _buildAccessCodeInput(theme, isDark), // ADDED: Access code input
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.chat, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            AppStrings.chatAssistant,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => setState(() {
              _isOpen = false;
              _isAuthenticated = false; // Reset authentication on close
              _accessCodeError = null; // Clear error
              _accessCodeController.clear(); // Clear input
            }),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  // ADDED: Widget for access code input
  Widget _buildAccessCodeInput(ThemeData theme, bool isDark) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.enterAccessCode,
              style: theme.textTheme.titleMedium?.copyWith(
                color: isDark ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            TextField(
              controller: _accessCodeController,
              keyboardType: TextInputType.number,
              obscureText: true, // Hide input for code
              decoration: InputDecoration(
                hintText: '****',
                errorText: _accessCodeError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _checkAccessCode(),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            ElevatedButton(
              onPressed: _checkAccessCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(bool isDark) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return MessageBubble(
            message: _messages[index],
            isDark: isDark,
          );
        },
      ),
    );
  }

  Widget _buildInputField(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: AppStrings.chatPlaceholder,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: theme.colorScheme.primary),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isDark;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.role == 'user';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primary
              : isDark
                  ? Colors.grey[800]
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: isUser
                ? Colors.white
                : isDark
                    ? Colors.white
                    : Colors.black,
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String role;
  final String content;

  ChatMessage({required this.role, required this.content});
}