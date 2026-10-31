import 'package:installed_apps/installed_apps.dart';
import 'app_info_model.dart';

class AppService {
  static Future<List<AppInfoModel>> getApps() async {
    final apps =  await InstalledApps.getInstalledApps(excludeSystemApps: false, excludeNonLaunchableApps: true, withIcon: true);

    List<AppInfoModel> result = [];

    // take data for each app
    for (var app in apps) {
      result.add(
        AppInfoModel(
          appName: app.name,
          packageName: app.packageName,
          icon: app.icon,
          isSelected: false
          )
      );
    }

    return result;

  }
}