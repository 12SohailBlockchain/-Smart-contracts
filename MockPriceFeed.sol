import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
pragma solidity >=0.8.0;

contract MockPriceFeed is AggregatorV3Interface {
    int256 private currentPrice;

    constructor(int256   _initialPrice)  {
        currentPrice = _initialPrice;
    }
    
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    function description() public view virtual override returns (string memory) {
        return "Mock Price Feed";
    }
    
    function version() public view virtual override returns (uint256) {
        return 1;
    }

    function latestRoundData()
        external
        view
        override
        returns(
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
       return (0, currentPrice, block.timestamp, block.timestamp, 0);
    }
    
    function getRoundData(uint80 _roundId)
        public
        view
        virtual
        override
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
       // Implement this function to return the correct data. 
       // It's recommended to keep the `latestRoundData()` as is and call it from here with _roundId parameter.
    }
}