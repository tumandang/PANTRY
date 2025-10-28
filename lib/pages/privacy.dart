import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy',style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Last updated: October 27, 2025',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            _buildIntroSection(),
            const SizedBox(height: 24),
            _buildSection(
              'Interpretation and Definitions',
              _buildDefinitionsContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Collecting and Using Your Personal Data',
              _buildDataCollectionContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Use of Your Personal Data',
              _buildDataUseContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Retention of Your Personal Data',
              _buildRetentionContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Transfer of Your Personal Data',
              _buildTransferContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Delete Your Personal Data',
              _buildDeleteContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Disclosure of Your Personal Data',
              _buildDisclosureContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Security of Your Personal Data',
              _buildSecurityContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Children\'s Privacy',
              _buildChildrenPrivacyContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Links to Other Websites',
              _buildLinksContent(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Changes to this Privacy Policy',
              _buildChangesContent(),
            ),
            const SizedBox(height: 24),
            _buildContactSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroSection() {
    return const Text(
      'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.\n\n'
      'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
      style: TextStyle(fontSize: 16, height: 1.5),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildDefinitionsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'For the purposes of this Privacy Policy:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 12),
        _buildDefinitionItem('Account', 'means a unique account created for You to access our Service or parts of our Service.'),
        _buildDefinitionItem('Affiliate', 'means an entity that controls, is controlled by, or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.'),
        _buildDefinitionItem('Application', 'refers to Campus Pantry, the software program provided by the Company.'),
        _buildDefinitionItem('Company', '(referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Campus Food Pantry.'),
        _buildDefinitionItem('Cookies', 'are small files that are placed on Your computer, mobile device or any other device by a website, containing the details of Your browsing history on that website among its many uses.'),
        _buildDefinitionItem('Country', 'refers to: Malaysia'),
        _buildDefinitionItem('Device', 'means any device that can access the Service such as a computer, a cell phone or a digital tablet.'),
        _buildDefinitionItem('Personal Data', 'is any information that relates to an identified or identifiable individual.'),
        _buildDefinitionItem('Service', 'refers to the Application or the Website or both.'),
        _buildDefinitionItem('Service Provider', 'means any natural or legal person who processes the data on behalf of the Company.'),
        _buildDefinitionItem('Usage Data', 'refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself.'),
        _buildDefinitionItem('Website', 'refers to Campus Food Pantry, accessible from https://eduhosting.top/campusfoodpantry/Home.html'),
        _buildDefinitionItem('You', 'means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.'),
      ],
    );
  }

  Widget _buildDefinitionItem(String term, String definition) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
          children: [
            TextSpan(
              text: '$term: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: definition),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCollectionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Types of Data Collected',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        const Text(
          'Personal Data',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('Email address'),
        _buildBulletPoint('First name and last name'),
        _buildBulletPoint('Usage Data'),
        const SizedBox(height: 16),
        const Text(
          'Usage Data',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Usage Data is collected automatically when using the Service. Usage Data may include information such as Your Device\'s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 16),
        const Text(
          'Information Collected while Using the Application',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('Pictures and other information from your Device\'s camera and photo library'),
        const SizedBox(height: 8),
        const Text(
          'We use this information to provide features of Our Service, to improve and customize Our Service. You can enable or disable access to this information at any time, through Your Device settings.',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildDataUseContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The Company may use Personal Data for the following purposes:',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 12),
        _buildBulletPoint('To provide and maintain our Service, including to monitor the usage of our Service.'),
        _buildBulletPoint('To manage Your Account: to manage Your registration as a user of the Service.'),
        _buildBulletPoint('For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased.'),
        _buildBulletPoint('To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication.'),
        _buildBulletPoint('To provide You with news, special offers, and general information about other goods, services and events.'),
        _buildBulletPoint('To manage Your requests: To attend and manage Your requests to Us.'),
        _buildBulletPoint('For business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets.'),
        _buildBulletPoint('For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns.'),
      ],
    );
  }

  Widget _buildRetentionContent() {
    return const Text(
      'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations, resolve disputes, and enforce our legal agreements and policies.\n\n'
      'The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service.',
      style: TextStyle(fontSize: 15, height: 1.5),
    );
  }

  Widget _buildTransferContent() {
    return const Text(
      'Your information, including Personal Data, is processed at the Company\'s operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ from those from Your jurisdiction.\n\n'
      'Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.\n\n'
      'The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.',
      style: TextStyle(fontSize: 15, height: 1.5),
    );
  }

  Widget _buildDeleteContent() {
    return const Text(
      'You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.\n\n'
      'Our Service may give You the ability to delete certain information about You from within the Service.\n\n'
      'You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.\n\n'
      'Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.',
      style: TextStyle(fontSize: 15, height: 1.5),
    );
  }

  Widget _buildDisclosureContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Business Transactions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 16),
        const Text(
          'Law Enforcement',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 16),
        const Text(
          'Other Legal Requirements',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('Comply with a legal obligation'),
        _buildBulletPoint('Protect and defend the rights or property of the Company'),
        _buildBulletPoint('Prevent or investigate possible wrongdoing in connection with the Service'),
        _buildBulletPoint('Protect the personal safety of Users of the Service or the public'),
        _buildBulletPoint('Protect against legal liability'),
      ],
    );
  }

  Widget _buildSecurityContent() {
    return const Text(
      'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially reasonable means to protect Your Personal Data, We cannot guarantee its absolute security.',
      style: TextStyle(fontSize: 15, height: 1.5),
    );
  }

  Widget _buildChildrenPrivacyContent() {
    return const Text(
      'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.\n\n'
      'If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent\'s consent before We collect and use that information.',
      style: TextStyle(fontSize: 15, height: 1.5),
    );
  }

  Widget _buildLinksContent() {
    return const Text(
      'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party\'s site. We strongly advise You to review the Privacy Policy of every site You visit.\n\n'
      'We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
      style: TextStyle(fontSize: 15, height: 1.5),
    );
  }

  Widget _buildChangesContent() {
    return const Text(
      'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.\n\n'
      'We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.\n\n'
      'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
      style: TextStyle(fontSize: 15, height: 1.5),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'If you have any questions about this Privacy Policy, You can contact us:',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('By visiting this page on our website: https://eduhosting.top/campusfoodpantry/Feedback.html'),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 15, height: 1.5)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}