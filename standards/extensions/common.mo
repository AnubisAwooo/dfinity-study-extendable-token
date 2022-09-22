// 元数据结构
//Common
// Metadata for either fungible of nft - may replace with single Blob
type Metadata = {
  #fungible : {
    name : Text; // 名称
    symbol : Text; // 符号
    decimals : Nat8; // 精度
    metadata : ?Blob; // 元数据
  };
  #nonfungible : {
    metadata : ?Blob; // nft 元数据
  };
};

type Token_common = actor {
  // 币种元数据
  metadata: shared query (token : TokenIdentifier) -> async Result<Metadata, CommonError>;
  // 币种供应量
  supply: shared query (token : TokenIdentifier) -> async Result<Balance, CommonError>;
};