import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        centerTitle: true,
        title: Text(
          'Help & Support',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'CalSans',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Chatbot Section
            _buildSection(
              context,
              '🤖 AI Chatbot Assistance',
              'Get instant help with our AI assistant',
              Icons.chat,
              [
                'Track food availability ("How many buns left?")',
                'Guide you to donation process',
                'Answer questions about pantry items',
                'Help with account issues',
              ],
              onTap: () {
                Navigator.pushNamed(context, '/chatbotpage');
              },
            ),

            const SizedBox(height: 24),

            // Expandable FAQ Section
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 8),
              child: ExpansionTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  '❓ Frequently Asked Questions',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CalSans',
                  ),
                ),
                subtitle: Text(
                  'Tap to expand and view common questions',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                children: [
                  _buildFAQItem(
                    context,
                    'How do I donate food items?',
                    'Go to the Donation page from the bottom navigation bar. Fill in the item details, expiration date, and quantity. Our team will review and confirm your donation.',
                  ),
                  _buildFAQItem(
                    context,
                    'Where can I find available pantry items?',
                    'Navigate to the Food page to see all available items. You can browse by category or use the search feature to find specific items.',
                  ),
                  _buildFAQItem(
                    context,
                    'How does the borrowing system work?',
                    'Browse available items on the Food page, add them to your cart, and proceed to checkout. You\'ll receive a pickup time and location confirmation.',
                  ),
                  _buildFAQItem(
                    context,
                    'What are the pantry operating hours?',
                    'The campus pantry is open Monday to Friday from 9:00 AM to 6:00 PM, and Saturdays from 10:00 AM to 2:00 PM. Closed on Sundays and public holidays.',
                  ),
                  _buildFAQItem(
                    context,
                    'How do I update my profile information?',
                    'Go to your Profile page from the navigation drawer. Tap on the edit icon to update your personal information, preferences, and contact details.',
                  ),
                  _buildFAQItem(
                    context,
                    'Can I track my donation history?',
                    'Yes! Visit your Profile page and tap on "Donation History" to see all your past donations and their current status.',
                  ),
                  _buildFAQItem(
                    context,
                    'What types of items can I donate?',
                    'We accept non-perishable food items, sealed packages, canned goods, and essential toiletries. All items must be within their expiration date.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Support
            _buildSection(
              context,
              '📞 Contact Support',
              'Get help from our team',
              Icons.support_agent,
              [
                'Email: support@unipantry.edu',
                'Campus Help Desk: Building A, Level 2',
                'Phone: +60 3-1234 5678',
                'Response Time: 24-48 hours',
              ],
            ),

            const SizedBox(height: 24),

            // Quick Guides Section
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 8),
              child: ExpansionTile(
                leading: Icon(
                  Icons.menu_book, // Changed from Icons.guide
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  '📚 Quick Guides',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CalSans',
                  ),
                ),
                subtitle: Text(
                  'Step-by-step instructions for main features',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                children: [
                  _buildGuideItem(
                    context,
                    'How to donate food items',
                    '1. Go to Donation page\n2. Tap "Add Donation"\n3. Fill item details\n4. Submit for review\n5. Receive confirmation',
                  ),
                  _buildGuideItem(
                    context,
                    'How to borrow from pantry',
                    '1. Browse Food page\n2. Add items to cart\n3. Review your cart\n4. Confirm pickup time\n5. Collect items',
                  ),
                  _buildGuideItem(
                    context,
                    'Using the scan feature',
                    '1. Tap camera icon\n2. Scan item barcode\n3. View item details\n4. Add to cart if available',
                  ),
                  _buildGuideItem(
                    context,
                    'Managing your profile',
                    '1. Open navigation drawer\n2. Tap "Profile"\n3. Edit information\n4. Save changes',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // System Information
            _buildSection(
              context,
              'ℹ️ System Information',
              'About UniPantry App',
              Icons.info,
              [
                'Version: 1.0.0',
                'Developed for Campus Use',
                'Academic Project - MIT License',
                'Last Updated: ${DateTime.now().year}',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    List<String> items, {
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CalSans',
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
            if (onTap != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onTap,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Open Chatbot'),
                      Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildGuideItem(BuildContext context, String title, String steps) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            steps,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
        ],
      ),
    );
  }
}