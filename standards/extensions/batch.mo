//Allow for batch calls
type BatchError = {
  #Error : Text;
};
type Token_allowance = actor {
  // 批量查询余额
  balance_batch: query (request : [BalanceRequest]) -> async Result<[BalanceResponse], BatchError>;

  // 批量转账
  transfer_batch: shared (request : [TransferRequest]) -> async Result<[TransferResponse], BatchError>;
};