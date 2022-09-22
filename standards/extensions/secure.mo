// 安全 替代查询
//Secure - replaces queries
type Token_secure = actor {
  // 拓展查询 安全
  extensions_secure : shared () -> async [Extension];
  // 元数据查询 安全
  metadata_secure: shared (token : TokenIdentifier) -> async Result<Metadata, CommonError>;
  // 供应量查询 安全
  supply_secure: shared (token : TokenIdentifier) -> async Result<Balance, CommonError>;
  // 余额查询 安全
  balance_secure: shared (request : BalanceRequest) -> async BalanceResponse;
};
