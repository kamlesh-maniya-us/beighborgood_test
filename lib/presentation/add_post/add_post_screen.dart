import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighborgood/_core/configs/injection.dart';
import 'package:neighborgood/_core/constant/extension_methods.dart';
import 'package:neighborgood/application/add_post/add_post_bloc.dart';
import 'package:neighborgood/presentation/_core/constant/assets.dart';
import 'package:neighborgood/presentation/_core/constant/utils.dart';
import 'package:neighborgood/presentation/_core/widgets/buttons.dart';
import 'package:neighborgood/presentation/add_post/widgets/description_text_field_widget.dart';
import 'package:neighborgood/presentation/add_post/widgets/title_text_field_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';

import '../../_core/configs/permission.dart';
import '../../_core/configs/theme_config.dart';
import '../../_core/constant/string_constants.dart';
import '../../domain/_core/failure.dart';
import '../_core/widgets/custom_toast.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddPostBloc>(),
      child: AddPostScreenUI(),
    );
  }
}

class AddPostScreenUI extends StatelessWidget {
  AddPostScreenUI({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostBloc, AddPostState>(listener: (context, state) {
      state.failureOrSuccess.fold(
        () => null,
        (a) => a.fold(
          (l) {
            switch (l) {
              case NetworkError():
                CustomToast.show(title: StringConstants.noInternetError);
                break;
              case ServerError():
                CustomToast.show(title: StringConstants.serverError);
                break;
            }
          },
          (r) => null,
        ),
      );
    }, builder: (context, state) {
      return AbsorbPointer(
        absorbing: state.isCreatingPost,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: Colors.white,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(20.0),
                child: PrimaryButton(
                  btnText: "Share",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddPostBloc>().add(CreatePost());
                    }
                  },
                ),
              ),
              appBar: AppBar(
                elevation: 0,
                titleSpacing: 0,
                surfaceTintColor: Colors.transparent,
                leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    key: const ValueKey("auth_otp_back_btn"),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      Assets.icBackSvg,
                    ),
                  ),
                ),
                centerTitle: false,
                title: Row(
                  children: [
                    Text(
                      "Create Post",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      BlocListener<AddPostBloc, AddPostState>(
                        listenWhen: (previous, current) =>
                            previous.isCreatingPost != current.isCreatingPost ||
                            previous.isPostCreated != current.isCreatingPost,
                        listener: (context, state) {
                          if (state.isCreatingPost) {
                            Utils(context).startLoading();
                          } else {
                            Utils(context).stopLoading();
                          }

                          if (state.isPostCreated) {
                            Navigator.pop(context, true);
                          }
                        },
                        child: const SizedBox(height: 36),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final result = await btnGalleryAction(context);

                          context.read<AddPostBloc>().add(SelectImage(image: result.first.path));
                        },
                        child: state.selectedFile.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(state.selectedFile),
                                  fit: BoxFit.cover,
                                  height: 185,
                                  width: 100.w,
                                ),
                              )
                            : Container(
                                width: 100.w,
                                height: 185,
                                color: AppTheme.feedBgColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 35,
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.icUploadImageSvg,
                                      height: 33,
                                      width: 27,
                                    ),
                                    const SizedBox(height: 22),
                                    Text(
                                      "Upload a  Image here",
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            fontSize: 14,
                                            decoration: TextDecoration.underline,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "JPG or PNG file size no more than 10MB",
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            fontSize: 14,
                                            color: Colors.black.withOpacity(0.4),
                                          ),
                                    )
                                  ],
                                ),
                              ).addDottedBorder(),
                      ),
                      const SizedBox(height: 16),
                      const TitleTextField(),
                      const SizedBox(height: 16),
                      const DescriptionTextField(),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

Future<List<File>> btnGalleryAction(
  BuildContext context, {
  bool selectMultiple = false,
}) async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt < 33) {
      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted || status == PermissionStatus.denied) {
        final isPermissionStatusGranted = await storagePermission();
        final images = await selectPhotoOrShowAppSettings(
          context,
          isPermissionStatusGranted,
          selectMultiple: selectMultiple,
        );

        if (images.isNotEmpty) {
          return images.map((e) => File(e?.path ?? "")).toList();
        }
      } else {
        Utils.showCustomDialog(
          context,
          title: "Need Permission",
          primaryBtnFunction: () async {
            await openAppSettings();
          },
          secondaryBtnFunction: () {
            Navigator.pop(context);
          },
          cancelBtnText: "Cancel",
          okBtnText: "Settings",
        );
      }
    } else {
      final status = await [Permission.photos].request();
      PermissionStatus? isPermissionStatusGranted = status[Permission.photos];
      final images = await selectPhotoOrShowAppSettings(
        context,
        isPermissionStatusGranted ?? PermissionStatus.denied,
        selectMultiple: selectMultiple,
      );
      if (images.isNotEmpty) {
        return images.map((e) => File(e?.path ?? "")).toList();
      }
    }
  } else {
    final status = await Permission.photos.status;
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    } else {
      try {
        final images = await chooseImage(
          source: ImageSource.gallery,
        );

        if (images.first != null) {
          return images.map((e) => File(e?.path ?? "")).toList();
        }
      } catch (err) {
        Utils.showCustomDialog(
          context,
          title: "Need Permission",
          primaryBtnFunction: () async {
            await openAppSettings();
          },
          secondaryBtnFunction: () {
            Navigator.pop(context);
          },
          cancelBtnText: "Cancel",
          okBtnText: "Settings",
        );
      }
    }
  }

  return [];
}

Future<List<XFile?>> selectPhotoOrShowAppSettings(
  BuildContext context,
  PermissionStatus status, {
  bool selectMultiple = false,
}) async {
  if (status == PermissionStatus.granted) {
    final image = await chooseImage(
      source: ImageSource.gallery,
    );

    final mimeType = lookupMimeType(image.first?.path ?? "");
    if (mimeType != "image/gif") {
      return [image.first];
    } else {
      CustomToast.show(title: "Add proper image");
    }
  } else if (status == PermissionStatus.permanentlyDenied) {
    Utils.showCustomDialog(
      context,
      title: "Need Permission",
      primaryBtnFunction: () async {
        await openAppSettings();
      },
      secondaryBtnFunction: () {
        Navigator.pop(context);
      },
      cancelBtnText: "Cancel",
      okBtnText: "Settings",
    );
  }

  return [];
}

Future<List<XFile?>> chooseImage({
  required ImageSource source,
}) async {
  try {
    final imgPicker = ImagePicker();

    final image = await imgPicker.pickImage(
      source: source,
      imageQuality: 50,
    );

    return [image];
  } catch (ex) {
    return [];
  }
}
