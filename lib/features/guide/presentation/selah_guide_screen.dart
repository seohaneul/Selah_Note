import 'package:flutter/material.dart';
import '../data/guide_template.dart';
import 'guide_write_screen.dart';
import 'guide_records_sheet.dart';

class SelahGuideScreen extends StatelessWidget {
  const SelahGuideScreen({Key? key}) : super(key: key);

  void _openRecords(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const GuideRecordsSheet(),
    );
  }

  void _startGuide(BuildContext context, GuideTemplate template) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuideWriteScreen(template: template),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('셀라 가이드', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.history, color: Colors.black87),
            label: const Text('기록 보기', style: TextStyle(color: Colors.black87)),
            onPressed: () => _openRecords(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '오늘의 묵상 주제를 선택해주세요.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '내 마음 상태에 맞는 질문을 통해\n말씀의 깊은 의미를 발견할 수 있습니다.',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            
            ...GuideTemplate.templates.map((template) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildTemplateCard(context, template),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard(BuildContext context, GuideTemplate template) {
    // 테마별 색상 지정
    Color bgColor;
    Color iconColor;
    IconData icon;
    
    switch (template.templateId) {
      case 'basic_01':
        bgColor = Colors.blue.shade50;
        iconColor = Colors.blue;
        icon = Icons.menu_book;
        break;
      case 'comfort_01':
        bgColor = Colors.pink.shade50;
        iconColor = Colors.pink;
        icon = Icons.favorite_border;
        break;
      case 'wisdom_01':
        bgColor = Colors.orange.shade50;
        iconColor = Colors.orange;
        icon = Icons.lightbulb_outline;
        break;
      case 'question_01':
      default:
        bgColor = Colors.green.shade50;
        iconColor = Colors.green;
        icon = Icons.help_outline;
        break;
    }

    return InkWell(
      onTap: () => _startGuide(context, template),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                ],
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.theme,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    template.description,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
