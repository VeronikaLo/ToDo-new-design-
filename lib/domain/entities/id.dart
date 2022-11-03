
import 'package:uuid/uuid.dart';

class UniqueID{
  const UniqueID._(this.value);

  final String value;
  
  // this factory makes id itself
  factory UniqueID(){
    return UniqueID._(const Uuid().v1());
  }

  //this factory gets id from extra (ex firebase)
  factory UniqueID.fromUniqueString(String uniqueID){
  return UniqueID._(uniqueID);
  }


}