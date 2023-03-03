import 'package:flutter/material.dart';

class SosComponent extends StatefulWidget {
  var isDisabledButton;
  String images;
  String title;

  SosComponent({
    super.key,
    required this.images,
    required this.title,
    this.isDisabledButton,
  });

  @override
  State<SosComponent> createState() => _SosComponentState();
}

class _SosComponentState extends State<SosComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: Container(
                foregroundDecoration: widget.isDisabledButton == true
                    ? null
                    : BoxDecoration(
                        color: Colors.grey,
                        backgroundBlendMode: BlendMode.saturation,
                      ),
                padding: EdgeInsets.zero,
                child: Image.asset(
                  widget.images,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              // '${widget.call().isDisabledButton}',
              '${widget.title}',
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  pirnt() {
    print(widget.isDisabledButton);
  }
}
