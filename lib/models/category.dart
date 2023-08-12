import 'package:flutter/material.dart';

enum Category {
  food,
  traveling,
  leisure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.traveling: Icons.flight_takeoff,
};
