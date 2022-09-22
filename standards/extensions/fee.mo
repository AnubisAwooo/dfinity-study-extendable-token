// 如果 token 需要转账费用，一定要把 token request 对象用下面这个
//Common
// If a token supports fee it must overwrite the default TransferRequest with this one
type TransferRequest = {
  from : User;
  to : User;
  token : TokenIdentifier;
  amount : Balance;
  fee : Balance; // 交易费
  memo : Memo;
  notify : Bool;
  subaccount : ?SubAccount;
};

type Token_fee = actor {
  // 查询交易费
  fee: (token : TokenIdentifier) -> async ();
};