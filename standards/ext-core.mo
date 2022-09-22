// 是否把转账抽取出来，仅仅提供拓展和余额的接口？移动转账接口到转账拓展里面？
//HM Do we abstract transfers out, and just have extensions and balance calls?
//and move transfer into a "transfer" extension?

// 子账户和 AID 支持原生地址
//SubAccount and AID to support native addresses
type AccountIdentifier = Text;
type SubAccount = [Nat8];

// 用户可以使任何 principal 或 canister，都可以持有一定余额
// A user can be any principal or canister, which can hold a balance
type User = {
  #address : AccountIdentifier; //No notification // ? 无通知？
  #principal : Principal; //defaults to sub account 0 // 默认子账户是 0
};

// token 的数量, 不限制大小？
// An amount of tokens, unbound
type Balance = Nat;

// 某 token 的全局标识
// ? 16 位编码，后面啥意思？
// A global uninque id for a token
//hex encoded, domain seperator + canister id + token index, variable length
type TokenIdentifier  = Text;

// canister中每个 token 的唯一序号，最多允许 2 的 32 次方个 token
//A canister unique index of each token. This allows for 2**32 individual tokens
type TokenIndex = Nat32;

// 拓展名称 例：batch 代币 batch 请求？
// Extension nane, e.g. 'batch' for batch requests
type Extension = Text;

// 转账时额外的数据，可以描述交易数据，也可以用于通知回调？
// Additional data field for transfers to describe the tx
// Data will also be forwarded to notify callback
type Memo : Blob;

// 通知回调数据结构
//Call back for notifications
type NotifyCallback = shared (TokenIdentifier, User, Balance, Memo) -> async ?Balance;
type NotifyService = actor { tokenTransferNotification : NotifyCallback};


// 通用错误
//Common error respone
type CommonError = {
  #InvalidToken: TokenIdentifier; // 无效的 token 标识符号
  #Other : Text; // 其他
};

// 请求和响应
//Requests and Responses
// 余额请求
type BalanceRequest = {
  user : User; // 用户
  token: TokenIdentifier; // token 标识
};
type BalanceResponse = Result<Balance, CommonError>; // 余额或者错误

// 转账请求
type TransferRequest = {
  from : User; // 转出用户
  to : User; // 转入用户
  token : TokenIdentifier; // token 标识
  amount : Balance; // 转账数量
  memo : Memo; // 备注 携带信息
  notify : Bool; // 是否通知回调
  subaccount : ?SubAccount; // 子账户
};
// 转账响应结果
type TransferResponse = Result<Balance, {
  #Unauthorized: AccountIdentifier; // 未授权的账户
  #InsufficientBalance; // 余额不足
  #Rejected; //Rejected by canister // canister 拒绝
  #InvalidToken: TokenIdentifier; // 无效的 token
  #CannotNotify: AccountIdentifier; // 无法通知
  #Other : Text; // 其他
}>;

// token 的接口
type Token = actor {
  extensions : query () -> async [Extension]; // 获取拓展，有哪些拓展

  balance: query (request : BalanceRequest) -> async BalanceResponse; // 余额查询

  transfer: shared (request : TransferRequest) -> async TransferResponse; // 转账请求
};