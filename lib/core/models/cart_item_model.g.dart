// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemModelAdapter extends TypeAdapter<CartItemModel> {
  @override
  final int typeId = 0;

  @override
  CartItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemModel(
      id: fields[0] as String,
      mealId: fields[1] as String,
      mealName: fields[2] as String,
      mealImageUrl: fields[3] as String,
      basePrice: fields[4] as double,
      quantity: fields[5] as int,
      totalPrice: fields[6] as double,
      selectedOptions: (fields[7] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
      addedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mealId)
      ..writeByte(2)
      ..write(obj.mealName)
      ..writeByte(3)
      ..write(obj.mealImageUrl)
      ..writeByte(4)
      ..write(obj.basePrice)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.totalPrice)
      ..writeByte(7)
      ..write(obj.selectedOptions)
      ..writeByte(8)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
