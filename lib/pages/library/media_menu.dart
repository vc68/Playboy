import 'package:flutter/material.dart';
import 'package:playboy/backend/library_helper.dart';
import 'package:playboy/backend/models/playitem.dart';
import 'package:playboy/backend/storage.dart';
import 'package:playboy/backend/utils/l10n_utils.dart';
import 'package:playboy/pages/home.dart';
import 'package:playboy/widgets/menu_item.dart';
import 'package:playboy/widgets/playlist_picker.dart';

List<Widget> buildCommonMediaMenuItems(
  BuildContext context,
  ColorScheme colorScheme,
  PlayItem item,
) {
  return [
    MMenuItem(
      icon: Icons.open_in_new,
      label: '播放器播放'.l10n,
      onPressed: () {
        AppStorage().closeMedia();
        AppStorage().openMedia(item);

        // if (!context.mounted) return;
        // pushRootPage(
        //   context,
        //   const PlayerPage(),
        // );
        // AppStorage().updateStatus();
        HomePage.switchView?.call();
      },
    ),
    MMenuItem(
      icon: Icons.play_circle_outline_rounded,
      label: '播放'.l10n,
      onPressed: () {
        AppStorage().closeMedia();
        AppStorage().openMedia(item);
      },
    ),
    MMenuItem(
      icon: Icons.last_page,
      label: '最后播放'.l10n,
      onPressed: null,
    ),
    MMenuItem(
      icon: Icons.add_circle_outline,
      label: '添加到播放列表'.l10n,
      onPressed: () {
        showDialog(
          useRootNavigator: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            // surfaceTintColor: Colors.transparent,
            title: Text('添加到播放列表'.l10n),
            content: SizedBox(
              width: 300,
              height: 300,
              child: ListView.builder(
                itemBuilder: (context, indexList) {
                  return SizedBox(
                    height: 60,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        LibraryHelper.addItemToPlaylist(
                          AppStorage().playlists[indexList],
                          item,
                        );
                        Navigator.pop(context);
                      },
                      child: PlaylistPickerItem(
                        info: AppStorage().playlists[indexList],
                      ),
                    ),
                  );
                },
                itemCount: AppStorage().playlists.length,
              ),
            ),
          ),
        );
      },
    ),
  ];
}
