# Simple Disbursement Contract

This projects aims to provide a simple and secure way of distributing tokens following a linear distribution through a Smart Contract that hold those tokens.
Implements a cliff time before no tokens are withdrawable.

Original author Stefan George - <stefan@gnosis.pm>, modified by New Order Team to add cliff vesting


## Configuration
Please update content in ./deploy-params.js

* **receiver**: ethereum address that will receive the tokens (note that you need to use that address to call the disbursement contract)
* **wallet**: ethereum address with powers for withdrawing unclaimed tokens from the contract
* **disbursementPeriod**: duration of the lineart distribution in seconds
* **startDate**: cliff for the disbursement, epoch time (in seconds)
* **token**: ethereum address for the ERC20 token contract

The Constructor function sets the following parameters:

_receiver Receiver of vested tokens

_wallet Gnosis multisig wallet address, which is allowed to withdraw all tokens anytime

_disbursementPeriod Vesting period in seconds

_startDate Start date of disbursement period

_cliffDate Date of cliff, before which tokens cannot be withdrawn

_token ERC20 token being vesting


## function withdraw
Transfers tokens to a given address, and has the following parameters:

 _to Address of token receiver

 _value Number of tokens to transfer
   

## function walletWithdraw
Transfers all tokens to the multisig wallet specified in the constructor. 
Can only be called by the `wallet` sepecified in the constructor.


## function calcMaxWithdraw   
Calculates the maximum amount of tokens that can be withdrawn at the current time

Returns the maximum number of vested tokens that can be withdrawn.


## Installation
```
npm i
```
or
```
yarn
```

## Run
```
npx truffle migrate
```
For more params (different networks) check in the truffle docs: https://www.trufflesuite.com/docs/truffle/reference/truffle-commands#migrate
