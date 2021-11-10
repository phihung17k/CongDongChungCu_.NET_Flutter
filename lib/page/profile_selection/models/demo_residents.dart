class Resident {
  final int id;
  final String apartmentName, buildingName;

  Resident({
    this.id,
    this.apartmentName,
    this.buildingName,
  });
}

List<Resident> demoResidents = [
  Resident(
    id: 1,
    apartmentName: 'Topaz Home',
    buildingName: 'Block 3'
  ),
  Resident(
      id: 2,
      apartmentName: 'Sky 9',
      buildingName: 'Block 1'
  ),
  Resident(
      id: 3,
      apartmentName: 'Vinhomes Grand Park',
      buildingName: 'Block 2'
  ),
];