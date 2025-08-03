import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../style/color/app_color.dart';
import '../../style/widgets/app_space.dart';
import '../../style/custom_widgets/custom_app_bar.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({this.imageUrl, super.key, this.title, this.imagesList});

  final String? imageUrl;
  final List<String>? imagesList;
  final String? title;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      appBar: CustomAppBar(title: title ?? '', tr: false),
      body:
          imagesList == null
              ? Center(
                child: InteractiveViewer(
                  panEnabled: false,
                  boundaryMargin: const EdgeInsets.all(20),
                  maxScale: 4,
                  child: Hero(
                    tag: 'imageHero',
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: imagesList!.length,
                      controller: pageController,
                      itemBuilder: (context, index) {
                        return InteractiveViewer(
                          panEnabled: false,
                          boundaryMargin: const EdgeInsets.all(20),
                          maxScale: 4,
                          child: Hero(
                            tag: 'imageHero',
                            child: Image.network(
                              imagesList![index],
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.height,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: imagesList!.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.blueAccent,
                          dotColor: AppColors.black,
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 4,
                        ),
                      ),
                    ),
                  ),
                  AppSpace(space: 20),
                ],
              ),
    );
  }
}
