//Provide a common interface between ICP ledger and ext-core
//This allows for instant support by exchanges
//TODO: work on this

// 账户余额参数
type AccountBalanceArgs = {
  account : AccountIdentifier; // 账户识别
  token : TokenIdentifier; // token 标识
};
type ICPTs = { e8s : Nat64 }; // 余额结构体
type BlockHeight = Nat64; // 交易高度
// 交易参数
type SendArgs = {
  to : AccountIdentifier; // 接收账户
  fee : ICPTs;  // 手续费
  memo : Nat64; // 备注 随机数
  from_subaccount : ?SubAccount; // 子账户
  created_at_time : ?{ timestamp_nanos : Nat64 }; // 创建时间
  amount : ICPTs; // 数量
  token : TokenIdentifier; // token 标识
};

type Token_ledger = actor actor {
  // 查询账户余额
  account_balance_dfx : shared query AccountBalanceArgs -> async ICPTs;
  // 转账交易
  send_dfx : shared SendArgs -> async BlockHeight;
}