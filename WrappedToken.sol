/*
██     ██ ██████   █████  ██████  ██████  ███████ ██████  ████████  ██████  ██   ██ ███████ ███    ██ 
██     ██ ██   ██ ██   ██ ██   ██ ██   ██ ██      ██   ██    ██    ██    ██ ██  ██  ██      ████   ██ 
██  █  ██ ██████  ███████ ██████  ██████  █████   ██   ██    ██    ██    ██ █████   █████   ██ ██  ██ 
██ ███ ██ ██   ██ ██   ██ ██      ██      ██      ██   ██    ██    ██    ██ ██  ██  ██      ██  ██ ██ 
 ███ ███  ██   ██ ██   ██ ██      ██      ███████ ██████     ██     ██████  ██   ██ ███████ ██   ████ 
                                                                                                                                                                                                    
*/

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WrappedToken is ERC20 {
    address public nativeToken;

    constructor(address _nativeToken) ERC20("Wrapped Token", "WTKN") {
        nativeToken = _nativeToken;
    }

    function wrap(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(
            IERC20(nativeToken).transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );
        _mint(msg.sender, amount);
    }

    function unwrap(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        _burn(msg.sender, amount);
        require(
            IERC20(nativeToken).transfer(msg.sender, amount),
            "Transfer failed"
        );
    }
}
