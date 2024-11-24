import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/presentation/widgets/search_filter_widget.dart';
import 'package:mobile_beresin/presentation/widgets/service_card.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late ServiceProvider serviceProvider = Provider.of(context, listen: false);

  String searchKeyword = '';

  Widget listProduk(ServiceProvider provider) {
    if (provider.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SliverPadding(
        padding: const EdgeInsets.all(15),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 16 / 20,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              ServiceModel service = provider.filteredServices[index];
              return ServiceCard(item: service);
            },
            childCount: provider.filteredServices.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 130,
                pinned: true,
                backgroundColor: alternativeBackgroundColor,
                automaticallyImplyLeading: false,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Text(
                  'Produk',
                  style: GoogleFonts.poppins(
                    color: alternativeBlackTextColor,
                    fontWeight: semibold,
                    fontSize: 24,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SearchFilterWidget(
                          placeHolder: 'Search service do you need',
                          onChanged: (p0) {
                            state.searchKeyword = p0;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              listProduk(state),

              // Consumer<ServiceProvider>(
              //   builder: (context, provider, child) {
              //     if (provider.isLoading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else {
              //       return SliverPadding(
              //         padding: const EdgeInsets.all(15),
              //         sliver: SliverGrid(
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 2,
              //             mainAxisSpacing: 10,
              //             crossAxisSpacing: 10,
              //             childAspectRatio: 16 / 20,
              //           ),
              //           delegate: SliverChildBuilderDelegate(
              //             (context, index) {
              //               ServiceModel service =
              //                   provider.filteredServices[index];
              //               return ServiceCard(item: service);
              //             },
              //             childCount: provider.filteredServices.length,
              //           ),
              //         ),
              //       );
              //     }
              //   },
              // )
            ],
          ),
        );
      },
    );
  }
}
