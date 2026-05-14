import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF3F51B5), // Indigo
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Greeting Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF03A9F4)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ສະບາຍດີ, ອາຈານ!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Sans Lao',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'ມື້ນີ້ທ່ານມີ 5 ລາຍການໃໝ່ທີ່ຕ້ອງກວດສອບ.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Noto Sans Lao',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Stats Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard('ຍອດຂາຍ', '₭ 2.5M', Colors.green),
              _buildStatCard('ຄຳສັ່ງຊື້', '120', Colors.orange),
              _buildStatCard('ລູກຄ້າ', '45', Colors.blue),
              _buildStatCard('ສິນຄ້າຄ້າງ', '5', Colors.red),
            ],
          ),
          const SizedBox(height: 24),

          // Menu Section
          const Text(
            'ເມນູຈັດການ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Noto Sans Lao',
            ),
          ),
          const SizedBox(height: 12),
          
          _buildMenuItem(
            icon: Icons.people,
            title: 'ຈັດການສະມາຊິກ',
            subtitle: 'ກວດສອບ ແລະ ເພີ່ມລາຍຊື່',
            iconColor: const Color(0xFF3F51B5),
          ),
          _buildMenuItem(
            icon: Icons.inventory_2,
            title: 'ຄັງສິນຄ້າ',
            subtitle: 'ກວດສອບຈຳນວນສິນຄ້າທີ່ເຫຼືອ',
            iconColor: const Color(0xFF3F51B5),
          ),
          _buildMenuItem(
            icon: Icons.settings,
            title: 'ຕັ້ງຄ່າລະບົບ',
            subtitle: 'ປັບແຕ່ງການເຮັດວຽກຂອງ App',
            iconColor: const Color(0xFF3F51B5),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color valueColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: 'Noto Sans Lao',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Add navigation logic if needed
        },
      ),
    );
  }
}
