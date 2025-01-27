import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/core/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePictureFromUrl extends StatelessWidget {
  final String? url;
  final VoidCallback? onPressedCamera;
  final bool isLoading;

  const ProfilePictureFromUrl({
    super.key,
    this.url,
    this.onPressedCamera,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final isUrlSafe = Uri.tryParse(url ?? '')?.isAbsolute ?? false;
    return CircleAvatar(
      radius: 50.0,
      backgroundColor: isUrlSafe
          ? Colors.transparent
          : context.theme.colorScheme.surfaceContainerHighest,
      child: Stack(
        children: [
          if (isUrlSafe) ...[
            Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: url ?? '',
                placeholder: (context, url) =>
                    CircularProgressIndicator.adaptive(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: imageProvider,
                ),
              ),
            ),
          ],
          if (!isUrlSafe) ...[
            Align(
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.image,
                size: 40,
                color: context.theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: context.theme.colorScheme.secondary,
              radius: 15,
              child: Builder(
                builder: (context) {
                  if (isLoading) {
                    return const CircularProgressIndicator(
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    );
                  }
                  return IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.photo_camera,
                      size: 15.0,
                      color: context.theme.colorScheme.onSecondary,
                    ),
                    onPressed: onPressedCamera,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
