// for globally available data
class GRID{
  int number;

  static final GRID _appData = new GRID._internal();

  factory GRID() {
    return _appData;
  }
  GRID._internal();

}

final grid = GRID();