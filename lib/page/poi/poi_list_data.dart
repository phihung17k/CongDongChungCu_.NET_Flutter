class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<HotelListData> hotelList = <HotelListData>[
      HotelListData(
      imagePath: 'http://wiki-travel.com.vn/uploads/post/camnhi-202124112127-khu-du-lich-suoi-tien.jpg',
      titleTxt: 'Khu du lịch văn hóa Suối Tiên',
      subTxt: 'Quốc Lộ 1, Tân Phú, Quận 9, Thành phố Hồ Chí Minh',
      dist: 2.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    HotelListData(
      imagePath: 'https://odt.vn/storage/10-2020/galleries/dat-nen-tho-cu-100-ngay-mt-duong-hoang-huu-nam-long-thanh-my-quan-9-gia-2-ty-205-trieu-125m2-16030164632.jpg',
      titleTxt: 'Phòng khám đa khoa',
      subTxt: 'Hoàng Hữu Nam, Long Thạnh Mỹ',
      dist: 1.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    HotelListData(
      imagePath: 'https://scontent-hkt1-1.xx.fbcdn.net/v/t1.18169-9/26166316_1463210667135164_3736673914375734712_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=730e14&_nc_ohc=IG209OSLbB0AX-cCPAA&_nc_ht=scontent-hkt1-1.xx&oh=4212cf55c7042da7194628eddfa3d519&oe=6189C270',
      titleTxt: 'Co.op Food',
      subTxt: 'Đường 154, phường Tân Phú',
      dist: 0.5,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'https://media.baodautu.vn/Images/vietdung/2021/07/12/Bnh_vin_Ung_Bu_2.jpg',
      titleTxt: 'Bệnh viện ung bướu cơ sở 2',
      subTxt: 'Quận 9',
      dist: 1.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
  ];
}
