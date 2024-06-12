
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../core/values/app_colors.dart';
import '../../core/values/app_images.dart';

class ProfileCircleImage extends GetView {
  const ProfileCircleImage({
    super.key,
    required this.imageUrl,
    required this.profileSize,
    this.localImage = "",
  });

  final String? imageUrl;
  final double profileSize;
  final String localImage;

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.grayLight2, width: 1),
        image: const DecorationImage(image: AssetImage(AppImages.noImg), fit:BoxFit.cover)
    );

    if(imageUrl == null || imageUrl!.isEmpty) {
     return Container(
          height: profileSize, width: profileSize,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.grayLight2, width: 1),
              image: localImage == ""
              ? const DecorationImage(image: AssetImage(AppImages.noImg), fit:BoxFit.cover)
              : DecorationImage(image: FileImage(File(localImage)), fit:BoxFit.cover)
          )
      );
    } else{
      return SizedBox(
        height: profileSize, width: profileSize,
        child: CachedNetworkImage(
              imageUrl: imageUrl!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.grayLight2, width: 1),
                    image: DecorationImage(image: imageProvider, fit:BoxFit.cover)
                ),
              ),
              placeholder: (context, url) => Container(decoration:decoration,child: const SpinKitDoubleBounce(color: AppColors.accentPrimary, size: 40)),
              errorWidget: (context, url, error) => Container( height: profileSize, width: profileSize, decoration: decoration),
             ),
      );
    }
  }
}

class CircleImage extends GetView {
  const CircleImage({Key? key, required this.imageUrl}) : super(key: key);
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if(imageUrl == null || imageUrl!.isEmpty) {
     return const CircleAvatar(radius: 24, backgroundImage:AssetImage(AppImages.noImg));
    }else{
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        imageBuilder: (context, imageProvider) =>CircleAvatar(radius: 24, backgroundImage: imageProvider),
        placeholder: (context, url) => const SpinKitDoubleBounce(color: AppColors.accentPrimary, size: 20),
        errorWidget: (context, url, error) => const CircleAvatar(radius: 24, backgroundImage:AssetImage(AppImages.noImg)),
      );
    }
  }
}