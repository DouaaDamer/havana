import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatelessWidget {
  final String id;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String company;
  final String jop;
  final String imageURL;
  final String signature;
  final DateTime calendar;
  final bool isAgree;
  const UserDetailsScreen({
    super.key,
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.company,
    required this.jop,
    required this.imageURL,
    required this.signature,
    required this.calendar,
    required this.isAgree,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عرض الصورة والتوقيع في الأعلى بجانب بعضهما البعض
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // عرض الصورة
                InkWell(
                  onTap: () {
                    showSignatureDialog(context, imageURL);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imageURL,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // عرض التوقيع
                InkWell(
                  onTap: () {
                    showSignatureDialog(context, signature);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      signature,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            listTitle(title: '$fname $lname', lading: 'Name:'),
            listTitle(title: email, lading: 'Email:'),
            listTitle(title: phone, lading: 'phone:'),
            listTitle(title: company, lading: 'Company:'),
            listTitle(title: jop, lading: 'Job:'),
            listTitle(title: id, lading: 'ID:'),
            listTitle(
                title: calendar.toLocal().toString().split(' ')[0],
                lading: 'Calendar:'),

            Card(
              child: ListTile(
                title: isAgree ? Text('موافق') : Text('لم يوافق'),
                subtitle: Text('هنا الشروط'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTitle({required String title, required String lading}) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: Text(lading),
        trailing: IconButton(
          icon: Icon(Icons.copy),
          onPressed: () {
            // نسخ النص إلى الحافظة
            Clipboard.setData(ClipboardData(text: title));
            // إظهار رسالة توضيحية
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(content: Text('Text copied to clipboard!')),
            );
          },
        ),
      ),
    );
  }

  void showSignatureDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Signature'),
          content: Container(
            width: double.maxFinite,
            child: Image.network(imageUrl),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                imageUrl = '';
                Navigator.of(context).pop(); // إغلاق الحوار
              },
            ),
          ],
        );
      },
    );
  }
}
