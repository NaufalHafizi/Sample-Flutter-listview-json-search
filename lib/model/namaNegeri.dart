import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Provider.dart';

listNegeri(index, loccode) {
    switch(int.parse(loccode)){
      case 0: 
        {
          return  "Johor";
        }
        break;
      case 1: 
        {
          return  "Kedah";
        }
        break;
      case 2: 
        {
          return  "Kelantan";
        }
        break;
      case 3: 
        {
          return  "Kuala Lumpur";
        }
        break;
      case 5: 
        {
          return  "Melaka";
        }
        break;
      case 6: 
        {
          return  "Negeri Sembilan";
        }
        break;
      case 7: 
        {
          return  "Pahang";
        }
        break;
      case 8: 
        {
          return  "Perak";
        }
        break;
      case 9: 
        {
          return  "Perlis";
        }
        break;
      case 10: 
        {
          return  "Penang";
        }
        break;
      case 12: 
        {
          return  "Sabah";
        }
        break;
      case 14: 
        {
          return  "Selangor";
        }
        break;
      case 16: 
        {
          return  "Terengganu";
        }
        break;
      case 100: 
        {
          return  "Singapore";
        }
        break;
      case 150: 
        {
          return  "Thailand";
        }
        break;
       default:
    }
  }