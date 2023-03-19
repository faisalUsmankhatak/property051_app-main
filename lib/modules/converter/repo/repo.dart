abstract class Repo {
  Future<bool> takeScreenShot(screenshotController);
}

abstract class AreaConverter {
  List<dynamic> convertUnit(selectedUnit, area, marlaSize);
}
