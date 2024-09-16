import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import '../values/app_colors.dart';

class StepWidget extends StatefulWidget {

  StepWidget({required this.step, super.key});
  int step = 0;

  @override
  State<StepWidget> createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget> {
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      enableStepTapping: false,
      activeStep: widget.step,
      borderThickness: 2,
      internalPadding: 4,
      stepRadius: 20,
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 0, vertical: 0),
      showLoadingAnimation: false,
      lineStyle: const LineStyle(
        lineType: LineType.normal,
        activeLineColor: AppColors.orange,
        unreachedLineColor: AppColors.grayLight2,
        finishedLineColor: AppColors.accentPrimary,
        unreachedLineType: LineType.dotted,
      ),

      activeStepBorderType: BorderType.dotted,
      activeStepBorderColor: AppColors.orange,
      activeStepIconColor: AppColors.orange,
      activeStepTextColor: AppColors.textColor,
      activeStepBackgroundColor: AppColors.orange.withOpacity(0.2),
      finishedStepBorderColor: AppColors.primary,
      finishedStepBorderType: BorderType.normal,
      finishedStepIconColor: AppColors.primary,
      finishedStepTextColor: AppColors.textColor,
      finishedStepBackgroundColor: AppColors.primary.withOpacity(0.2),
      unreachedStepBorderType: BorderType.dotted,
      unreachedStepBorderColor: AppColors.bodyTextColor,
      unreachedStepTextColor: AppColors.bodyTextColor,
      unreachedStepIconColor: AppColors.bodyTextColor,
      unreachedStepBackgroundColor: AppColors.bodyTextColor.withOpacity(0.2),

      onStepReached: (index) => setState(() => widget.step = index),
      steps: const [
        EasyStep(title: 'Pending', icon: Icon(Icons.pending_actions_rounded),),
        EasyStep(title: 'Approved', icon: Icon(Icons.download_done_rounded)),
        EasyStep(title: 'Processing', icon: Icon(Icons.autorenew_rounded)),
        EasyStep(title: 'Delivered', icon: Icon(Icons.directions_bus)),
      ],
    );
  }
}
