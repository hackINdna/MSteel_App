// import 'package:flutter/material.dart';

// class ImagePickerModalBottomSheet extends StatelessWidget {
//   final Function() onDeletePressed;
//   const ImagePickerModalBottomSheet({
//     super.key,
//     required this.onDeletePressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return showModalBottomSheet(
//         //context: context,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         )),
//         builder: (context) => Container(
//               padding: const EdgeInsets.all(12),
//               height: MediaQuery.of(context).size.height * 0.21,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         transText(context).uploadPhoto,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () => onDeletePressed.call(),
//                         icon: Icon(Icons.delete, color: themeColors.last),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ));
//   }
// }
