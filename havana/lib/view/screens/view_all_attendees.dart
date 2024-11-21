// lib/view/view_all_attendees.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:havana/controller/attendees_controller.dart';
import 'package:havana/models/attendee_model.dart';
import 'package:havana/view/screens/user_details_screen.dart';
import 'package:intl/intl.dart';

class ViewAllAttendees extends StatelessWidget {
  final AttendeesController attendeesController =
      Get.put(AttendeesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View All Attendees'),
      ),
      body: Obx(() {
        if (attendeesController.attendees.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () => attendeesController.fetchAttendees(),
          child: ListView(
            children: attendeesController.getSortedAttendees().map((entry) {
              DateTime date = entry.key;
              List<AttendeeModel> attendees = entry.value;

              attendees.sort((a, b) => b.calendar.compareTo(a.calendar));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...attendees.map((attendee) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(() => UserDetailsScreen(
                              id: attendee.id,
                              isAgree: attendee.isAgree,
                              fname: attendee.fname,
                              lname: attendee.lname,
                              email: attendee.email,
                              phone: attendee.phone,
                              company: attendee.company,
                              jop: attendee.jop,
                              imageURL: attendee.imageURL,
                              signature: attendee.signature,
                              calendar: attendee.calendar));
                        },
                        title: Text('${attendee.fname} ${attendee.lname}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${attendee.email}'),
                            // Text('Phone: ${attendee.phone}'),
                            //Text('Company: ${attendee.company}'),
                            Text('ID: ${attendee.id}'),
                          ],
                        ),

                        // leading: InkWell(
                        //   onTap: () {
                        //     _showSignatureDialog(context, attendee.imageURL);
                        //   },
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(15),
                        //     child: Container(
                        //       height: 50,
                        //       width: 50,
                        //       child: CachedNetworkImage(
                        //         imageUrl: attendee.imageURL,
                        //         fit: BoxFit.cover,
                        //         placeholder: (context, url) =>
                        //             Center(child: CircularProgressIndicator()),
                        //         errorWidget: (context, url, error) =>
                        //             Text('error_loading_image'.tr + ': $error'),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.jm().format(attendee.calendar),
                                ),
                                InkWell(
                                    onTap: () {
                                      attendeesController.showSignatureDialog(
                                          context, attendee.signature);
                                    },
                                    child: const Text(
                                      'عرض التوقيع',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const Divider(),
                ],
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}
