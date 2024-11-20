import 'package:bloc/bloc.dart';
import 'package:todolistapp/feature/splash/presenatation/bloc/splashstate.dart';

class SplashCubit extends Cubit<SplashState>{
  SplashCubit():super(SplashInitialState());


  void appStarted()async{
   await Future.delayed(Duration(seconds: 2));
    emit(SplashSuccessState());
  }
}