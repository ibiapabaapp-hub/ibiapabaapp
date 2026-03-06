import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class CacheDatabaseService {
  static late Database db;

  static Future<void> init() async {
    final appDir = await getApplicationCacheDirectory();
    await appDir.create(recursive: true);
    final dbPath = join(appDir.path, 'ibiapabaapp_cache.db');
    db = await databaseFactoryIo.openDatabase(dbPath);
  }
}
