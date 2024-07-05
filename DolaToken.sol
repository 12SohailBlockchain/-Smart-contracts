/*

██████   ██████  ██       █████  
██   ██ ██    ██ ██      ██   ██ 
██   ██ ██    ██ ██      ███████ 
██   ██ ██    ██ ██      ██   ██ 
██████   ██████  ███████ ██   ██ 
                                 
                                 
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contracts/AggregatorV3Interface.sol";

contract DOLA is ERC20 {
    address public roiToken;
    address public bdolaToken;
    AggregatorV3Interface internal roiPriceFeed;
    AggregatorV3Interface internal bdolaPriceFeed;
 
    constructor(
        address _roiToken,
        address _bdolaToken,
        address _roiPriceFeed,
        address _bdolaPriceFeed
    ) ERC20("DOLA", "DOLA") {
        roiToken = _roiToken;
        bdolaToken = _bdolaToken;
        roiPriceFeed = AggregatorV3Interface(_roiPriceFeed);
        bdolaPriceFeed = AggregatorV3Interface(_bdolaPriceFeed);
    }

    function mint(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        uint256 roiValue = getROIValue();
        uint256 collateralRequired = amount * roiValue;
        require(
            ERC20(bdolaToken).transferFrom(msg.sender, address(this), collateralRequired),
            "Transfer failed"
        );
        _mint(msg.sender, amount);
    }

    function burn(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        uint256 roiValue = getROIValue();
        uint256 collateralToReturn = amount * roiValue;
        _burn(msg.sender, amount);
        require(
            ERC20(bdolaToken).transfer(msg.sender, collateralToReturn),
            "Transfer failed"
        );
    }

    function getROIValue() public view returns (uint256) {
        (, int256 price, , , ) = roiPriceFeed.latestRoundData();
        return uint256(price);
    }

    function getBDOLAValue() public view returns (uint256) {
        (, int256 price, , , ) = bdolaPriceFeed.latestRoundData();
        return uint256(price);
    }
}
