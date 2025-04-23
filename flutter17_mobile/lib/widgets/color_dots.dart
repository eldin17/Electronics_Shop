import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/models/product_color.dart';
import 'package:flutter17_mobile/widgets/rounded_icon_btn.dart';

class ColorDots extends StatefulWidget {
  final Product product;
  int selectedColor;
  ValueChanged<ProductColor> changeProductColor;
  ValueChanged<int> changeQuantity;

  ColorDots(
      {super.key,
      required this.product,
      required this.selectedColor,
      required this.changeProductColor,
      required this.changeQuantity});

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int quantity = 1;
  int selectedColorMarker = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedColorMarker = widget.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
            widget.product.productColors!.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectedColor = index;
                  selectedColorMarker = index;
                });
                print("${widget.product.productColors![index].name}");
                widget.changeProductColor(widget.product.productColors![index]);
              },
              child: ColorDot(
                color:
                    hexToColor(widget.product.productColors![index].hexCode!),
                isSelected: index == selectedColorMarker,
              ),
            ),
          ),
          const Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                if (quantity > 1) {
                  quantity--;
                  widget.changeQuantity(quantity);
                }
                ;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "$quantity",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                if (quantity <
                    widget
                        .product.productColors![widget.selectedColor].stock!) {
                  quantity++;
                  widget.changeQuantity(quantity);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatefulWidget {
  final Color color;
  bool isSelected;

  ColorDot({
    Key? key,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<ColorDot> createState() => _ColorDotState();
}

class _ColorDotState extends State<ColorDot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
            color: widget.isSelected
                ? const Color(0xFFFF7643)
                : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

