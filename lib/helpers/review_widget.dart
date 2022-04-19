import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserReview extends StatefulWidget {
  final RequestModel request;
  const UserReview(this.request, {Key? key}) : super(key: key);
  @override
  _UserReviewState createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  late double _rating;
  final reviewController = TextEditingController();
  String feel = '0';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    return Container(
      width: size.width,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Leave a Rating',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              SizedBox(
                height: 100,
                child: Transform.scale(
                  scale: 2,
                  child: FlareActor(
                    'assets/feelings.flr',
                    fit: BoxFit.contain,

                    //alignment: Alignment.Center,
                    animation: feel,
                  ),
                ),
              ),
              RatingBar(
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                      if (rating.floor() == 5) {
                        feel = '100';
                      } else if (rating.floor() == 4) {
                        feel = '75';
                      } else if (rating.floor() == 3) {
                        feel = '50';
                      } else if (rating.floor() == 2) {
                        feel = '25';
                      } else if (rating.floor() == 1) {
                        feel = '10';
                      } else {
                        feel = '0';
                      }
                    });
                  },
                  itemSize: 30,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                    ),
                    empty: const Icon(
                      Icons.star_border,
                      color: Colors.amber,
                    ),
                  )), // MySlid(),

              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                    maxLines: null,
                    controller: reviewController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Write a review',
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          )),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('userData')
                      .doc('bookings')
                      .collection(uid)
                      .doc(widget.request.id)
                      .update({'status': 'done'});
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 13),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget buildReview() {
    return Container(
      child: RatingBar(
        ratingWidget: RatingWidget(
          full: const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          half: const Icon(
            Icons.star_half,
            color: Colors.amber,
          ),
          empty: const Icon(
            Icons.star_border,
            color: Colors.amber,
          ),
        ),
        onRatingUpdate: (rating) => setState(() => _rating = rating),
        allowHalfRating: true,
        itemSize: 25,
      ),
    );
  }
}
