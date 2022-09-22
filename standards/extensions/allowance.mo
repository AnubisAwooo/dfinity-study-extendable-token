// 增加允许额度 想 erc20 那样
// 还是通过 transfer 进行转账，里面有个 from 参数
//Add erc20 like allowances
//We use transfer still not transferFrom (as transfer has a from field)
// 允许额度查询请求
type AllowanceRequest = {
  owner : User; // token 拥有者
  spender : Principal; // 被授权的人 ？？？ 这个应该 canister 也允许才是
  token : TokenIdentifier; // token 标识
};

// 进行授权额度的请求
type ApproveRequest = {
  token : TokenIdentifier; // token 标识
  subaccount : ?SubAccount; // 子账户
  spender : Principal; // 被授权人， 可以是 canister 也可以是其他人
  allowance : Balance; // 授权额度
};

type Token_allowance = actor {
  // 查询允许额度
  allowance: shared query (request : AllowanceRequest) -> async async Result<Balance, CommonError>;
  // 进行授权
  approve: shared (request : ApproveRequest) -> async ();
};