import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/slider_provider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  late Future sliderFuture;

  @override
  void didChangeDependencies() {
    sliderFuture = Provider.of<SliderProvider>(context).getDataSlider();

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: FutureBuilder(
        future: sliderFuture,
        initialData: const [],
        builder: (context, asyncData) {
          final sliderData = asyncData.hasData ? asyncData.data as List : [];
          return asyncData.hasData
              ? CarouselSlider(
                  options: CarouselOptions(height: 200.0, autoPlay: true),
                  items: sliderData.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(i.image))),
                        );
                      },
                    );
                  }).toList(),
                )
              : Container(child: const Text("no data"));
        },
      ),
    );
  }
}
