// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.18;

import "@rmrk-team/evm/contracts/RMRK/multiasset/RMRKMultiAsset.sol";

contract AdvancedMultiAsset is RMRKMultiAsset {
    // NOTE: Additional custom arguments can be added to the constructor based on your needs.
    constructor(string memory name, string memory symbol)
        RMRKMultiAsset(name, symbol)
    {
        // Custom optional: constructor logic
    }

    // Custom expected: external, optionally gated, functions to mint.
    // Available internal functions:
    //  _mint(address to, uint256 tokenId)
    //  _safeMint(address to, uint256 tokenId)
    //  _safeMint(address to, uint256 tokenId, bytes memory data)

    // Custom expected: external gated function to burn.
    // Available internal functions:
    //  _burn(uint256 tokenId)

    // Custom expected: external, optionally gated, function to add assets.
    // Available internal functions:
    //  _addAssetEntry(uint64 id, string memory metadataURI)

    // Custom expected: external, optionally gated, function to add assets to tokens.
    // Available internal functions:
    //  _addAssetToToken(uint256 tokenId, uint64 assetId, uint64 replacesAssetWithId)

    // Custom optional: utility functions to transfer from caller
    // Available public functions:
    //  transferFrom(address from, address to, uint256 tokenId)
}
