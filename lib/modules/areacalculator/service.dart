class AreaConverterService1 {
  List convertUnit(selectedUnit, area, marlaSize) {
    var values = [];
    values.add(convert(selectedUnit, 1, area, marlaSize));
    values.add(convert(selectedUnit, 2, area, marlaSize));
    values.add(convert(selectedUnit, 3, area, marlaSize));
    values.add(convert(selectedUnit, 4, area, marlaSize));
    values.add(convert(selectedUnit, 5, area, marlaSize));
    values.add(convert(selectedUnit, 6, area, marlaSize));
    return values;
  }

  double convert(selectedUnit, convertUnit, area, marlaSize) {
    var sqFeets =
        units.where((e) => e['unit_id'] == selectedUnit).first['in_sqft'];
    if (selectedUnit == convertUnit) {
      return area;
    }
    if (marlaSize == 225) {
      var sqFeets1 =
          units.where((e) => e['unit_id'] == convertUnit).first['in_sqft'];
      return area *
          (double.parse(sqFeets.toString()) /
              double.parse(sqFeets1.toString()));
    } else if (marlaSize == 250) {
      if ((selectedUnit < 4 && convertUnit < 4) ||
          (selectedUnit > 3 && convertUnit > 3)) {
        var sqFeets1 =
            units.where((e) => e['unit_id'] == convertUnit).first['in_sqft'];
        return area *
            (double.parse(sqFeets.toString()) /
                double.parse(sqFeets1.toString()));
      } else if (selectedUnit < 4 && convertUnit > 3) {
        var sqFeets1 =
            units.where((e) => e['unit_id'] == convertUnit).first['in_sqft1'];
        sqFeets =
            units.where((e) => e['unit_id'] == selectedUnit).first['in_sqft1'];
        print(
            'sqFeets: $sqFeets, sqFeets1: $sqFeets1 selectedUnit: $selectedUnit, convertUnit: $convertUnit');
        return area *
            (double.parse(sqFeets.toString()) /
                double.parse(sqFeets1.toString()));
      } else if (selectedUnit > 3 && convertUnit < 4) {
        var sqFeets1 =
            units.where((e) => e['unit_id'] == convertUnit).first['in_sqft1'];
        sqFeets =
            units.where((e) => e['unit_id'] == selectedUnit).first['in_sqft1'];
        return area *
            (double.parse(sqFeets.toString()) /
                double.parse(sqFeets1.toString()));
      }
    } else if (marlaSize == 272) {
      if ((selectedUnit < 4 && convertUnit < 4) ||
          (selectedUnit > 3 && convertUnit > 3)) {
        var sqFeets1 =
            units.where((e) => e['unit_id'] == convertUnit).first['in_sqft'];
        return area *
            (double.parse(sqFeets.toString()) /
                double.parse(sqFeets1.toString()));
      } else if (selectedUnit < 4 && convertUnit > 3) {
        var sqFeets1 =
            units.where((e) => e['unit_id'] == convertUnit).first['in_sqft2'];
        sqFeets =
            units.where((e) => e['unit_id'] == selectedUnit).first['in_sqft2'];
        print(
            'sqFeets: $sqFeets, sqFeets1: $sqFeets1 selectedUnit: $selectedUnit, convertUnit: $convertUnit');
        return area *
            (double.parse(sqFeets.toString()) /
                double.parse(sqFeets1.toString()));
      } else if (selectedUnit > 3 && convertUnit < 4) {
        var sqFeets1 =
            units.where((e) => e['unit_id'] == convertUnit).first['in_sqft2'];
        sqFeets =
            units.where((e) => e['unit_id'] == selectedUnit).first['in_sqft2'];
        return area *
            (double.parse(sqFeets.toString()) /
                double.parse(sqFeets1.toString()));
      }
    }
    return 0;
  }
}

var units = [
  {
    "unit_id": 1,
    "unit_name": "Sq.F",
    "in_sqft": "1",
    "in_sqft1": "1",
    "in_sqft2": "1",
  },
  {
    "unit_id": 2,
    "unit_name": "Sq.M",
    "in_sqft": "10.764",
    "in_sqft1": "10.764",
    "in_sqft2": "10.764",
  },
  {
    "unit_id": 3,
    "unit_name": "Sq.Y",
    "in_sqft": "9",
    "in_sqft1": "9",
    "in_sqft2": "9",
  },
  {
    "unit_id": 4,
    "unit_name": "Marla",
    "in_sqft": "225",
    "in_sqft1": "250",
    "in_sqft2": "272",
  },
  {
    "unit_id": 5,
    "unit_name": "Kanal",
    "in_sqft": "4500",
    "in_sqft1": "5000",
    "in_sqft2": "5440",
  },
  {
    "unit_id": 6,
    "unit_name": "Acre",
    "in_sqft": "36000",
    "in_sqft1": "40000",
    "in_sqft2": "43520",
  },
];
