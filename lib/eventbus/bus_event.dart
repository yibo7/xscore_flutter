import 'package:event_bus/event_bus.dart';

class ApplicationEvent {
  static EventBus event;
  //发布一个消息
  static void send<T>(T obj){
    ApplicationEvent.event.fire(obj);
  }
  //使用示例
  // StreamSubscription<BlueCloseEvent> _listenColse;
  // _listenColse = ApplicationEvent.event.on<BlueCloseEvent>().listen((event)async {
  // isBlueClose = event.isColse;
// });
}
