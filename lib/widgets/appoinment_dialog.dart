import 'package:flutter/material.dart';

class AppointmentDialog {
  showAppoinmentDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: MediaQuery.of(context).size.height * 0.60,
                width: MediaQuery.of(context).size.width * 0.20,
                child: Scaffold(
                  appBar: AppBar(title: Text('Nueva cita')),
                ),
              ));
        });
  }
}

// Container(
//               height: MediaQuery.of(context).size.height * 0.40,
//               width: MediaQuery.of(context).size.width * 0.10,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'What do you want to remember?'),
//                     ),
//                     SizedBox(
//                       width: 320.0,
//                       child: RaisedButton(
//                         onPressed: () {},
//                         child: Text(
//                           "Save",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         color: const Color(0xFF1BC0C5),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
