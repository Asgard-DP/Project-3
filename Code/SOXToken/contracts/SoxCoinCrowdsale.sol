pragma solidity ^0.5.17;

import "./SoxCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Have the KaseiCoinCrowdsale contract inherit:
// * Crowdsale
// * MintedCrowdsale
contract SoxCoinCrowdsale is Crowdsale, MintedCrowdsale{ 
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint rate,
        address payable wallet,
        SoxCoin token
    ) Crowdsale(rate, wallet, token) public {
        // constructor can stay empty
    }
}


contract SoxCoinCrowdsaleDeployer {
    // Create an `address public` variable called `Sox_token_address`.
    address public Sox_token_address;
    // Create an `address public` variable called `Sox_crowdsale_address`.
    address public Sox_crowdsale_address;

    // Add the constructor.
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet 
    ) public {
        // Create a new instance of the SoxCoin contract.
        SoxCoin token = new SoxCoin(name, symbol, 0);
        
        // Assign the token contract’s address to the `Sox_token_address` variable.
        Sox_token_address = address(token);

        // Create a new instance of the `SoxCoinCrowdsale` contract
        SoxCoinCrowdsale SoxCoin_crowdsale = new SoxCoinCrowdsale(1, wallet, token);
        
        // Aassign the `SoxCoinCrowdsale` contract’s address to the `Sox_crowdsale_address` variable.
        Sox_crowdsale_address = address(SoxCoin_crowdsale);

        // Set the `SoxCoinCrowdsale` contract as a minter
        token.addMinter(Sox_crowdsale_address);
        
        // Have the `SoxCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}