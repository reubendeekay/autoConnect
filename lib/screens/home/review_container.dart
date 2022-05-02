import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mechanic/helpers/review_widget.dart';
import 'package:mechanic/models/request_model.dart';

class ReviewContainer extends StatefulWidget {
  const ReviewContainer({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  State<ReviewContainer> createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        isLoading = true;
      });
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              children: [UserReview(widget.request)]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: isLoading ? 0 : 1,
            child: Lottie.asset('assets/repair.json')));
  }
}
