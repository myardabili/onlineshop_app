import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  final List<String> items;
  const BannerSlider({super.key, required this.items});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.items
              .map((e) => Image.asset(
                    e,
                    height: 206.0,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 315 / 152,
            viewportFraction: 1,
            disableCenter: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              _current = index;
              setState(() {});
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
