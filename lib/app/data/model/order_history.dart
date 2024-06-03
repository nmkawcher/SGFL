class OrderHistory{

  String? orderID;
  String? status;
  String? location;
  String? amount;
  DateTime? dateTime;

  OrderHistory({this.orderID, this.amount, this.status, this.location, this.dateTime});

  static List<OrderHistory> orderList =[
    OrderHistory(orderID: '25516216',amount: '12000', status: 'pending', location: 'Sarulia bazar, Demra, Dhaka',dateTime: DateTime.now()),
    OrderHistory(orderID: '25516216',amount: '12000', status: 'pending', location: 'Sarulia bazar, Demra, Dhaka',dateTime: DateTime.now()),
    OrderHistory(orderID: '25516216',amount: '12000', status: 'pending', location: 'Sarulia bazar, Demra, Dhaka',dateTime: DateTime.now()),
    OrderHistory(orderID: '25516216',amount: '12000', status: 'pending', location: 'Sarulia bazar, Demra, Dhaka',dateTime: DateTime.now()),
    OrderHistory(orderID: '25516216',amount: '12000', status: 'pending', location: 'Sarulia bazar, Demra, Dhaka',dateTime: DateTime.now()),
    OrderHistory(orderID: '25516216',amount: '12000', status: 'pending', location: 'Sarulia bazar, Demra, Dhaka',dateTime: DateTime.now()),

  ];


}