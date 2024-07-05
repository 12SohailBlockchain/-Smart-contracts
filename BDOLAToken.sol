// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ROIToken is ERC20 {
    constructor() ERC20("ROI Token", "ROI") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}

contract BDOLAToken is ERC20 {
    constructor() ERC20("BDOLA Token", "BDOLA") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}

contract EmpressToken is ERC20 {
    constructor() ERC20("Empress Token", "EMP") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}