import 'package:app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      width: size.width * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: Column(
        children: [
          Container(
            height: size.height * 0.23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("assets/banner/aaaa.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Үнэ",
                style: TextStyle(color: AppColors.textcolor),
              ),
              Text(
                "70,000₮",
                style: TextStyle(color: AppColors.textcolor),
              )
            ],
          ),
          Row(
            children: [
              Text('Тайлбар'),
            ],
          )
        ],
      ),
    );
  }
}
