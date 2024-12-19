import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_shop/components/banner.dart';
import 'package:coffee_shop/components/category_item.dart';
import 'package:coffee_shop/components/item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/coffee_item.dart';
import 'package:coffee_shop/components/custom_bottom_nav.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:coffee_shop/components/user_profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedCategory = 0;
  List<String> list = ['Cappuccino', 'Machiato', 'Latte', 'Americano'];
  String _currentAddress = "Loading...";
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentAddress = "Location permission denied";
            _isLoadingLocation = false;
          });
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress = "${place.locality}, ${place.subAdministrativeArea}";
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = "Error getting location";
        _isLoadingLocation = false;
      });
    }
  }

  Stream<List<CoffeeItem>> _getCoffeeItems() {
    return FirebaseFirestore.instance
        .collection('coffee_items')
        .where('category', isEqualTo: list[selectedCategory])
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CoffeeItem.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 260,
              width: size.width,
              decoration: const BoxDecoration(color: Color(0xff131313)),
            ),
            Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 315,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.040),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location",
                                  style: GoogleFonts.sora(
                                    color: const Color(0xffB7B7B7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                                      ),
                                      child: Text(
                                        _currentAddress,
                                        style: GoogleFonts.sora(
                                          color: const Color(0xffDDDDDD),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    if (_isLoadingLocation)
                                      const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    else
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                  ],
                                )
                              ],
                            ),
                            UserProfile()
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.030,
                        ),
                        SizedBox(
                          height: 52,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xff313131),
                              contentPadding: const EdgeInsets.only(
                                top: 23,
                                bottom: 2,
                                right: 5,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: "Search coffee",
                              hintStyle: GoogleFonts.sora(
                                color: const Color(0xff989898),
                              ),
                              prefixIcon: const Icon(
                                Iconsax.search_normal,
                                color: Colors.white,
                                size: 20,
                              ),
                              suffixIcon: Container(
                                width: 44,
                                height: 44,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xffC67C4E),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Iconsax.setting_4,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        SizedBox(
                          width: 315,
                          height: 140,
                          child: CarouselSlider(
                            options: CarouselOptions(
                                viewportFraction: 1,
                                enlargeFactor: 0.3,
                                height: size.height * 0.22,
                                enlargeCenterPage: true,
                                autoPlay: true,
                            ),
                            items: List.generate(
                              5,
                              (index) => const BannerCard(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.030,
                        ),
                        SizedBox(
                          height: 40,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                list.length,
                                (index) => CategoryItem(
                                  index: index,
                                  title: list[index],
                                  selectedCategory: selectedCategory,
                                  onClick: () {
                                    setState(() => selectedCategory = index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 315,
                    alignment: Alignment.center,
                    child: StreamBuilder<List<CoffeeItem>>(
                      stream: _getCoffeeItems(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final coffeeItems = snapshot.data ?? [];

                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: size.width / 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 239,
                          ),
                          itemCount: coffeeItems.length,
                          itemBuilder: (context, index) {
                            final item = coffeeItems[index];
                            return Item(
                              name: item.name,
                              description: item.description,
                              price: item.price,
                              rating: item.rating,
                              imageUrl: item.imageUrl,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
