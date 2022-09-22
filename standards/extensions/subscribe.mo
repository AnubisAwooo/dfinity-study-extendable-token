// 订阅 支持订阅通知模型
//Subscribe - support a subscription model for notifications
type Token_subscribe = actor {
  // 订阅
  subscribe: shared (callback : NotifyCallback) -> ();
  // 取消订阅
  unsubscribe : shared () -> ();
};