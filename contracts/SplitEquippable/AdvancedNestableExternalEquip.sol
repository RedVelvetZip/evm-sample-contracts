// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.18;

import "@rmrk-team/evm/contracts/RMRK/equippable/RMRKNestableExternalEquip.sol";

contract AdvancedNestableExternalEquip is RMRKNestableExternalEquip {
    // NOTE: Additional custom arguments can be added to the constructor based on your needs.
    constructor(string memory name, string memory symbol)
        RMRKNestableExternalEquip(name, symbol)
    {
        // Custom optional: constructor logic
    }

    // Custom expected: external, optionally gated, functions to mint.
    // Available internal functions:
    //  _mint(address to, uint256 tokenId)
    //  _safeMint(address to, uint256 tokenId)
    //  _safeMint(address to, uint256 tokenId, bytes memory data)

    // Custom expected: external, optionally gated, functions to nest mint.
    // Available internal functions:
    //  _nestMint(address to, uint256 tokenId, uint256 destinationId)

    // Custom expected: external gated function to burn.
    // Available internal functions:
    //  _burn(uint256 tokenId)

    // Custom optional: external gated function to set equippableAddress
    // Available internal functions:
    //  _setEquippableAddress(address equippable)

    // Custom optional: utility functions to transfer and nest transfer from caller
    // Available public functions:
    //  transferFrom(address from, address to, uint256 tokenId)
    //  nestTransfer(address from, address to, uint256 tokenId, uint256 destinationId)
}
