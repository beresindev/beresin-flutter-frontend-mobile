import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/common/token_manager.dart';
import 'package:mobile_beresin/models/user_model.dart';
import 'package:mobile_beresin/presentation/pages/auth/login_page.dart';
import 'package:mobile_beresin/presentation/widgets/carousel_widget.dart';
import 'package:mobile_beresin/presentation/widgets/service_tile.dart';
import 'package:mobile_beresin/providers/auth_provider.dart';
import 'package:mobile_beresin/providers/dashboard_provider.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late ServiceProvider serviceProvider =
      Provider.of<ServiceProvider>(context, listen: false);
  late UserModel user;

  late Future<void> futureGetServices;
  Future<void> getAllServices() async {
    await serviceProvider.getAllServices();
  }

  @override
  void initState() {
    super.initState();
    user = context.read<AuthProvider>().user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      futureGetServices = getAllServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hai ${user.name}',
                  style: GoogleFonts.poppins(
                    color: primaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Selamat Datang di Baresin, Sewa Cepat Tanpa Ribet!',
                  style: GoogleFonts.poppins(
                    color: primaryTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                TokenManager().clearToken();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
              icon: Icon(
                Icons.exit_to_app,
                color: alternativeWhiteTextColor,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: CarouselWidget(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Layanan Terbaru",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<DashboardProvider>().setIndex(1);
                        },
                        child: Text(
                          "Lihat Semua",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: alternativeBlackTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Consumer<ServiceProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: provider.services.length >= 5
                            ? 5
                            : provider.services.length,
                        itemBuilder: (context, index) {
                          return ServiceTile(item: provider.services[index]);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
