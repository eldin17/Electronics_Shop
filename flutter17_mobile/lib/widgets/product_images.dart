import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/product_image.dart';

class ProductImages extends StatefulWidget {
  List<ProductImage> list;
  ProductImages({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  void didUpdateWidget(covariant ProductImages oldWidget) {
    // TODO: implement didUpdateWidget
    selectedImage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            colors: [
              Colors.white.withOpacity(1), 
              Colors.white.withOpacity(0), 
            ],
            stops: [0.8, 1], 
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 238,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                    adjustImage(widget.list[selectedImage].image!.path!)),
              ),
            ),
            // SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,5,0,20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          widget.list.length,
                          (index) => SmallProductImage(
                            isSelected: index == selectedImage,
                            press: () {
                              setState(() {
                                selectedImage = index;
                              });
                            },
                            image: adjustImage(widget.list[index].image!.path!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage(
      {super.key,
      required this.isSelected,
      required this.press,
      required this.image});

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.fromLTRB(8,0,8,0),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Color(0xFFFF7643).withOpacity(widget.isSelected ? 1 : 0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 53, 53, 53).withOpacity(0.15),
              blurRadius: 5,
              offset: const Offset(0, 4), // Soft drop shadow
            ),
          ],
        ),
        child: Image.network(widget.image),
      ),
    );
  }
}