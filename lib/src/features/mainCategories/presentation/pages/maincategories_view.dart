import 'package:flutter/material.dart';
import 'package:tiwee/src/features/home/presentation/widgets/footer.dart';
import 'package:tiwee/src/features/home/presentation/widgets/header.dart';

class MainCategoriesPage extends StatefulWidget {
  const MainCategoriesPage({super.key});

  @override
  State<MainCategoriesPage> createState() => _MainCategoriesPageState();
}

class _MainCategoriesPageState extends State<MainCategoriesPage> {
  Map<String, dynamic> client = {};
  Map<String, dynamic> channelGroups = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

      print("arguments:" + args.toString());
    if (args != null && args is Map) {
      client = Map<String, dynamic>.from(args['client'] ?? {});
      channelGroups = Map<String, dynamic>.from(args['groups'] ?? {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 35, 43, 130),
              Color.fromARGB(255, 8, 44, 98)
            ],
          ),
        ),
        child: Column(
          children: [
            const HeaderApp(),

            // 🧠 Dynamic Group List from Cached Channels
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                  itemCount: channelGroups.keys.length,
                  itemBuilder: (context, index) {
                    final groupName = channelGroups.keys.elementAt(index);
                    return _buildGroupCard(groupName);
                  },
                ),
              ),
            ),

            // Pass client data to footer
            FooterApp(
              username: client['username'] ?? 'N/A',
              expiresAt: client['expire_time'] ?? 'Unlimited',
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildGroupCard(String title) {
    return Card(
      color: Colors.black26,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
        onTap: () {
          // Next step: open channel list inside the group
        },
      ),
    );
  }
}
