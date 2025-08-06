

import '../classes/stutusconntection.dart';

handlingData(response){
  if (response is StatusRequest){
   return response ; 
  }else {
   return StatusRequest.seccuss ;
  }
}