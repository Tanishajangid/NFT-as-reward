// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PeerRecognitionNFT {
    string public name = "PeerRecognitionNFT";
    string public symbol = "PRNFT";
    uint256 public tokenCounter;

    struct Recognition {
        address recipient;
        string message;
        uint256 tokenId;
    }

    mapping(uint256 => Recognition) public recognitions;
    mapping(uint256 => address) private _owners;

    event RecognitionMinted(address indexed recipient, uint256 tokenId, string message);

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
        tokenCounter = 0;
    }

    function mintRecognition(address recipient, string memory message) public onlyOwner {
        uint256 tokenId = tokenCounter;
        _owners[tokenId] = recipient;
        recognitions[tokenId] = Recognition(recipient, message, tokenId);
        emit RecognitionMinted(recipient, tokenId, message);
        tokenCounter++;
    }

    function getRecognition(uint256 tokenId) public view returns (address, string memory, uint256) {
        require(_exists(tokenId), "Token does not exist");
        Recognition memory recognition = recognitions[tokenId];
        return (recognition.recipient, recognition.message, recognition.tokenId);
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        return _owners[tokenId] != address(0);
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "Token does not exist");
        return _owners[tokenId];
    }
} 
