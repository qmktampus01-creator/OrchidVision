import 'package:flutter/material.dart';
import 'package:orchid_vision/app/theme/app_colors.dart';

class OrchiAiPage extends StatefulWidget {
  const OrchiAiPage({super.key});

  @override
  State<OrchiAiPage> createState() => _OrchiAiPageState();
}

class _OrchiAiPageState extends State<OrchiAiPage> {
  final TextEditingController _inputController = TextEditingController();
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: 'Hi there! I can help diagnose orchid issues and suggest care steps. Ask me anything about your plant.',
      isUser: false,
    ),
  ];

  final List<String> _promptSuggestions = [
    'Why are my orchid leaves yellow?',
    'What is the best watering schedule?',
    'How much light does my orchid need?',
    'What does leaf spotting mean?',
    'How can I improve humidity?',
  ];

  bool _isSending = false;

  void _sendMessage([String? customText]) {
    final text = (customText ?? _inputController.text).trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _inputController.clear();
      _isSending = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      final response = _generateResponse(text);
      setState(() {
        _messages.add(_ChatMessage(text: response, isUser: false));
        _isSending = false;
      });
    });
  }

  String _generateResponse(String prompt) {
    final normalized = prompt.toLowerCase();

    final keywords = <String, List<String>>{
      'water': [
        'Water your orchid when the top 2 cm of soil feels dry. Avoid overwatering and let excess water drain away quickly.',
        'Orchids normally prefer a careful watering routine. Use room-temperature water and only water again after the medium begins to dry.',
      ],
      'leaf spot': [
        'Leaf spots often indicate fungal or bacterial infection. Remove the damaged tissue, improve ventilation, and keep leaves dry while watering.',
        'Check for humidity and airflow issues. Most leaf spot problems improve when you stop wetting the foliage and treat with a mild fungicide if available.',
      ],
      'light': [
        'Orchids like bright, indirect light. A sheer curtain or east-facing window is best; avoid direct midday sun to prevent leaf burns.',
        'Too little light can prevent blooming, while too much direct light can scorch leaves. Balanced indirect light is ideal.',
      ],
      'bloom': [
        'For stronger blooms, keep temperatures stable and feed lightly with orchid fertilizer during the growing season.',
        'Encourage flowering by maintaining a consistent humidity level and gently watering on a schedule suited to your orchid type.',
      ],
      'humidity': [
        'Orchids like humidity around 50–70%. Use a tray of damp pebbles, group plants together, or run a humidifier nearby.',
        'Misting once or twice a day can help in dry air, but avoid leaving leaves wet overnight to reduce rot risk.',
      ],
    };

    for (final entry in keywords.entries) {
      if (normalized.contains(entry.key)) {
        return entry.value[(DateTime.now().millisecondsSinceEpoch % entry.value.length)];
      }
    }

    if (normalized.contains('yellow')) {
      return 'Yellow leaves often mean too much water, low light, or age-related natural leaf drop. Check your watering schedule first and adjust light gently.';
    }

    if (normalized.contains('root') || normalized.contains('roots')) {
      return 'Healthy orchid roots should be firm and green or white. Soft, brown roots usually mean overwatering or poor drainage. Repot if the medium is old.';
    }

    if (normalized.contains('fertilizer') || normalized.contains('feed')) {
      return 'Feed orchids with a balanced orchid fertilizer during active growth. Use it at half strength every 2–4 weeks rather than full strength each time.';
    }

    if (normalized.contains('pests') || normalized.contains('insect') || normalized.contains('aphid')) {
      return 'Inspect leaves and roots carefully; common pests include mealybugs and spider mites. Wipe leaves with mild soap solution and isolate the plant if needed.';
    }

    return 'Tell me more about the issue or symptom and I will suggest the best care steps. You can ask about watering, light, humidity, pests, and blooming.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'OrchAI',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'AI Assistant Care Bot',
                style: TextStyle(
                  color: AppColors.surface,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _promptSuggestions
                    .map(
                      (suggestion) => ActionChip(
                        label: Text(suggestion),
                        onPressed: () => _sendMessage(suggestion),
                        backgroundColor: AppColors.surfaceSoft,
                        labelStyle: const TextStyle(color: AppColors.textPrimary),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            return _chatBubble(message);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _inputController,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _sendMessage(),
                              decoration: InputDecoration(
                                hintText: 'Ask about your orchid’s health...',
                                filled: true,
                                fillColor: AppColors.surfaceSoft,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: _isSending ? null : _sendMessage,
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _isSending ? AppColors.divider : AppColors.accent,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                _isSending ? Icons.hourglass_top : Icons.send,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatBubble(_ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.accent : AppColors.surfaceSoft,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? AppColors.white : AppColors.textPrimary,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}
