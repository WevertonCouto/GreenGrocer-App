import 'package:green_grocer/src/models/cart_item_model.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/models/user_model.dart';

import '../models/item_model.dart';

List<CartItemModel> cartItems = [
  // CartItemModel(item: apple, quantity: 2),
  // CartItemModel(item: guava, quantity: 3),
  // CartItemModel(item: papaya, quantity: 1),
];

UserModel userModel = UserModel(
    name: 'Weverotn Couto',
    email: 'weverton@email.com',
    phone: '99 9 9999-9999',
    cpf: '999.999.999-38',
    password: 'teste',
    id: '',
    token: '');

List<OrderModel> orders = [
  // OrderModel(
  //   copyAndPaste: 'q1w2e3r4t5y6',
  //   createdDateTime: DateTime.parse(
  //     '2022-06-08 10:00:10.458',
  //   ),
  //   overdueDateTime: DateTime.parse(
  //     '2022-06-08 11:00:10.458',
  //   ),
  //   id: 'asd6a54da6s2d1',
  //   status: 'refunded',
  //   total: 11.0,
  //   items: [
  //     CartItemModel(
  //       item: apple,
  //       quantity: 2,
  //     ),
  //     CartItemModel(
  //       item: mango,
  //       quantity: 2,
  //     ),
  //     CartItemModel(
  //       item: guava,
  //       quantity: 1,
  //     ),
  //   ],
  // ),
  // OrderModel(
  //   copyAndPaste: 'q1w2e3r4t5y6',
  //   createdDateTime: DateTime.parse(
  //     '2022-06-08 10:00:10.458',
  //   ),
  //   overdueDateTime: DateTime.parse(
  //     '2022-06-08 11:00:10.458',
  //   ),
  //   id: 'a65s4d6a2s1d6a5s',
  //   status: 'delivered',
  //   total: 11.5,
  //   items: [
  //     CartItemModel(
  //       item: guava,
  //       quantity: 1,
  //     ),
  //     CartItemModel(
  //       item: guava,
  //       quantity: 1,
  //     ),
  //   ],
  // ),
  // OrderModel(
  //   copyAndPaste: 'q1w2e3r4t5y6',
  //   createdDateTime: DateTime.parse(
  //     '2022-06-08 10:00:10.458',
  //   ),
  //   overdueDateTime: DateTime.parse(
  //     '2023-06-08 11:00:10.458',
  //   ),
  //   id: 'a65s4d6a2s1d6a5s',
  //   status: 'delivered',
  //   total: 11.5,
  //   items: [
  //     CartItemModel(
  //       item: guava,
  //       quantity: 1,
  //     ),
  //     CartItemModel(
  //       item: guava,
  //       quantity: 1,
  //     ),
  //   ],
  // ),
  // OrderModel(
  //   copyAndPaste: 'q1w2e3r4t5y6',
  //   createdDateTime: DateTime.parse(
  //     '2022-06-08 10:00:10.458',
  //   ),
  //   overdueDateTime: DateTime.parse(
  //     '2023-06-08 11:00:10.458',
  //   ),
  //   id: 'a65s4d6a2s1d6a5s',
  //   status: 'pending_payment',
  //   total: 11.5,
  //   items: [
  //     CartItemModel(
  //       item: guava,
  //       quantity: 1,
  //     ),
  //     CartItemModel(
  //       item: guava,
  //       quantity: 1,
  //     ),
  //   ],
  // )
];
