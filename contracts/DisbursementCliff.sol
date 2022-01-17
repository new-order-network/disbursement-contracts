pragma solidity ^0.6.0;
import  "@gnosis.pm/util-contracts/contracts/Token.sol";


/// @title Disbursement contract - allows to distribute tokens over time with a cliff
/// @author Stefan George - <stefan@gnosis.pm> modified by New Order Team
contract DisbursementCliff {

    /*
     *  Storage
     */
    address public receiver;
    address public wallet;
    uint public disbursementPeriod;
    uint public startDate;
    uint public cliffDate;
    uint public withdrawnTokens;
    Token public token;

    /*
     *  Modifiers
     */
    modifier isReceiver() {
        if (msg.sender != receiver)
            revert("Only receiver is allowed to proceed");
        _;
    }

    modifier isWallet() {
        if (msg.sender != wallet)
            revert("Only wallet is allowed to proceed");
        _;
    }

    /*
     *  Public functions
     */
    /// @dev Constructor function sets the wallet address, which is allowed to withdraw all tokens anytime
    /// @param _receiver Receiver of vested tokens
    /// @param _wallet Gnosis multisig wallet address
    /// @param _disbursementPeriod Vesting period in seconds
    /// @param _startDate Start date of disbursement period
    /// @param _cliffDate Time of cliff, before which tokens cannot be withdrawn
    /// @param _token ERC20 token used for the vesting
    constructor(address _receiver, address _wallet, uint _disbursementPeriod, uint _startDate, uint _cliffDate, Token _token)
        public
    {
        if (_receiver == address(0) || _wallet == address(0) || _disbursementPeriod == 0 || address(_token) == address(0))
            revert("Arguments are null");
        receiver = _receiver;
        wallet = _wallet;
        disbursementPeriod = _disbursementPeriod;
        startDate = _startDate;
        cliffDate = _cliffDate;
        token = _token;
        if (startDate == 0){
          startDate = now;
        }
        if (cliffDate < startDate){
            cliffDate = startDate;
        }
    }

    /// @dev Transfers tokens to a given address
    /// @param _to Address of token receiver
    /// @param _value Number of tokens to transfer
    function withdraw(address _to, uint256 _value)
        public
        isReceiver
    {
        uint maxTokens = calcMaxWithdraw();
        if (_value > maxTokens){
          revert("Withdraw amount exceeds allowed tokens");
        }
        withdrawnTokens += _value;
        token.transfer(_to, _value);
    }

    /// @dev Transfers all tokens to multisig wallet
    function walletWithdraw()
        public
        isWallet
    {
        uint balance = token.balanceOf(address(this));
        withdrawnTokens += balance;
        token.transfer(wallet, balance);
    }

    /// @dev Calculates the maximum amount of vested tokens
    /// @return Number of vested tokens to withdraw
    function calcMaxWithdraw()
        public
        view
        returns (uint)
    {
        uint maxTokens = (token.balanceOf(address(this)) + withdrawnTokens) * (now - startDate) / disbursementPeriod;
        if (withdrawnTokens >= maxTokens || startDate > now || cliffDate > now){
          return 0;
        }
        return maxTokens - withdrawnTokens;
    }
}