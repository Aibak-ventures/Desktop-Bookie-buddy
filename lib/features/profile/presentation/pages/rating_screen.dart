// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// Future<void> showRating(
//   BuildContext context,
// ) async {
//   double stars = 4;
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 'assets/images/logo.png',
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: RatingBar.builder(
//                   initialRating: 3,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
//                   itemBuilder: (context, _) => const Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   onRatingUpdate: (rating) {
//                     stars = rating;
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     style: OutlinedButton.styleFrom(
//                       backgroundColor:
//                           Theme.of(context).scaffoldBackgroundColor,
//                       side: BorderSide(
//                           color: Theme.of(context).scaffoldBackgroundColor),
//                     ),
//                     child: const Text(
//                       'Close',
//                     ),
//                   ),
//                   OutlinedButton(
//                     onPressed: () async {
//                       if (stars > 3) {
//                         // final Uri url = Uri.parse(
//                         //     'https://play.google.com/store/apps/details?id=com.app.artinyou');
//                         // if (!await launchUrl(url)) {
//                         //   throw Exception('Could not launch $url');
//                         // }
//                       } else {
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Center(
//                                     child: Text(
//                                   '🥺',
//                                   style: TextStyle(
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 )),
//                                 const Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'We are sorry to hear that!',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                                 const Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'Would you like to give us feedback ?',
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     OutlinedButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                           Navigator.pop(context);
//                                         },
//                                         style: OutlinedButton.styleFrom(
//                                           backgroundColor: Theme.of(context)
//                                               .scaffoldBackgroundColor,
//                                           side: BorderSide(
//                                               color: Theme.of(context)
//                                                   .scaffoldBackgroundColor),
//                                         ),
//                                         child: const Text(
//                                           'No',
//                                         )),
//                                     OutlinedButton(
//                                         onPressed: () async {
//                                           final Uri uri = Uri(
//                                             scheme: 'mailto',
//                                             path:
//                                                 'aibaksoftwaresolutions@gmail.com',
//                                           );

//                                           if (await canLaunchUrl(uri)) {
//                                             await launchUrl(
//                                               uri,
//                                               mode: LaunchMode
//                                                   .externalApplication, // Open in the default email app
//                                             );
//                                           } else {
//                                             throw 'Could not launch $uri';
//                                           }
//                                         },
//                                         style: OutlinedButton.styleFrom(
//                                           backgroundColor: Colors.green,
//                                           side: const BorderSide(
//                                               color: Colors.green),
//                                         ),
//                                         child: const Text(
//                                           'Yes',
//                                         ))
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: Colors.green),
//                       backgroundColor: Colors.green,
//                     ),
//                     child: const Text(
//                       'Continue',
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         );
//       });
// }
