import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/presentation/widgets/draft_produk_card.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class DraftServicePage extends StatefulWidget {
  const DraftServicePage({super.key});

  @override
  State<DraftServicePage> createState() => _DraftServicePageState();
}

class _DraftServicePageState extends State<DraftServicePage> {
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = Provider.of<ServiceProvider>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            color: alternativeBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 7.0,
                spreadRadius: 1.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  'Draft Produk',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600, // semibold
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Total: ',
                style: GoogleFonts.poppins(
                  color: alternativeBlackColor,
                  fontSize: 12,
                ),
              ),
              Text(
                '${serviceProvider.draftServices.length} Produk',
                style: GoogleFonts.poppins(
                  color: alternativeBlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: serviceProvider.draftServices.isEmpty
                    ? [
                        Center(
                          child: Text(
                            'Tidak ada draft produk.',
                            style: GoogleFonts.poppins(
                              color: alternativeBlackColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ]
                    : [
                        const SizedBox(
                          height: 20,
                        ),
                        ...serviceProvider.draftServices.map(
                          (produk) => DraftProdukCard(item: produk),
                        )
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
