import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingAppointmentsShimmer extends StatelessWidget {
  const UpcomingAppointmentsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: size.height * 0.09,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: size.width * 0.3,
                      height: 16,
                      color: Colors.grey.shade400,
                    ),
                    const Spacer(),
                    Container(
                      width: size.width * 0.2,
                      height: 16,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.settings, color: Colors.grey.shade400),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
