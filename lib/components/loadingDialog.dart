import 'package:flutter/material.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
                backgroundColor: trans,
                elevation: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: white,
                      ),
                      child: const LoadingIndicator(
                        indicatorType: Indicator.ballClipRotateMultiple,
                        colors: [bluebg],
                      ),
                    ),
                  ],
                ),
              );
  }
}