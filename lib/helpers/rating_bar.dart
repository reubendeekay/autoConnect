import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:rating_bar/rating_bar.dart';

class Ratings extends StatefulWidget {
  final double? size;
  final bool? isEdit;
  final double? rating;
  final Color? color;
  const Ratings(
      {Key? key,
      this.size,
      this.isEdit,
      this.rating,
      this.color = Colors.amber})
      : super(key: key);

  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  // ignore: unused_field
  double _rating = .50;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isEdit == null
          ? RatingBar.readOnly(
              initialRating: widget.rating,
              isHalfAllowed: true,
              filledColor: widget.color,
              size: widget.size ?? 14.0,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
            )
          : RatingBar(
              onRatingChanged: (rating) => setState(() => _rating = rating),
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              halfFilledIcon: Icons.star_half,
              isHalfAllowed: true,
              filledColor: kPrimaryColor,
              emptyColor: Colors.amber,
              halfFilledColor: kPrimaryColor,
              size: widget.size ?? 14.0,
            ),
    );
  }
}
