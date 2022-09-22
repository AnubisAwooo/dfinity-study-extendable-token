// 挖 nft 的参数
//NFT
type MintRequest = {
  to : User; // 用户
  metadata : ?Blob; // 元数据
};
type Token_nonfungible = actor {
  // 持有者  某个 token 的持有者
  bearer: shared query (token : TokenIdentifier) -> async Result<AccountIdentifier, CommonError>;

  // 挖 nft
  mintNFT: shared (request : MintRequest) -> async ();
};
