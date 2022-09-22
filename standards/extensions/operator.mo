// token 模式
type Tokens = {
  #All; //all tokens for all balances // 所有的token
  #Some: (TokenIdentifier, ?Balance); //null balance for all balancer of that token //  null 表示该 token 的所有余额
};

// 操作模式
type OperatorAction = {
  #SetOperator: Tokens; // 设置操作人
  #RemoveOperator: ?[TokenIdentifier]; //null removes from all // 移除操作人，null 表示移除所有
};

// 操作请求
type OperatorRequest = {
  subaccount: ?SubAccount; // 子账户
  operators: [(Principal, OperatorAction)] // 操作人和操作模式
};

// 响应
type OperatorResponse = Result<(), {
  #Unauthorized;
}>;
// 查询是否授权请求
type IsAuthorizedRequest = {
  owner: User; // 用户
  operator: Princpal; // 操作人
  token : TokenIdentifier // token 表示
  amount: Balance; // 金额
};

// token 授权
type Token_allowance = actor {
  // 更新操作人？
  updateOperator : shared (request : OperatorRequest) -> async OperatorResponse;
  // 查询是否授权
  isAuthorized : shared (request : IsAuthorizedRequest) -> async Result<Bool, CommonError>;
};