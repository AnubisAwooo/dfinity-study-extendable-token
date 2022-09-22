//Archive extension to allow for storage of txs/retreival of txs
//TODO
type Date = Nat64;
type TransactionId = Nat;

// 交易信息
type Transaction = {
  txid : TransactionId; // 交易 id
  request : TransferRequest; // 转账请求
  date : Date; // 时间
};

// 查询交易请求
type TransactionsRequest = {
  query : {
    #txid : TransactionId; // 交易 id
    #user : User; // 某用户
    #date : (Date, Date); //from - to // 时间范围
    #page : (Nat, Nat); // all per page - page // 分页
    #all; // 所有
  }
  token : TokenIdentifier; // token 表示
};

//Private/internal add function for archive

// token压缩的接口
type Token_archive = actor {
  // 新增 token 转账记录
  add : shared (request : TransferRequest) -> TransactionId;
  // 查询交易
  transactions : query (request : TransactionsRequest) -> async Result<[Transaction], CommonError>;
};