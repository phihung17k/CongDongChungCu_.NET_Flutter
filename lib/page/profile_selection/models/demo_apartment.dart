import 'demo_building.dart';

class Apartment {
  final int id;
  final String name;
  final String address;
  final List<Building> buildingList;

  Apartment({
    this.id,
    this.name,
    this.address,
    this.buildingList,
  });
}


List<Apartment> demoApartment = [
  Apartment(
    id: 1,
    name: 'Topaz Home',
    buildingList: demoBuilding1
  ),
  Apartment(
      id: 2,
      name: 'Sky 9',
    buildingList: demoBuilding2
  ),
  Apartment(
      id: 3,
      name: 'Vinhomes Grand Park',
    buildingList: demoBuilding3
  ),
];