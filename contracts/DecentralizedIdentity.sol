// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVerifier {
    function verify(bytes calldata _proof, bytes32[] calldata _publicInputs) external view returns (bool);
}

contract DecentralizedIdentity {

    IVerifier _verifier;

    constructor (IVerifier verifier)  {
        _verifier = verifier;
    }
    
    struct Identity {
        bool isRegistered;
        uint256 age;
        string skill;
        string university;
        uint256 reputation;
    }

    mapping(address => Identity) public identities;
    mapping(address => bool) public admin;

    event DIDRegistered(address indexed user);

    modifier onlyAdmin() {
        require(admin[msg.sender], "Sender not authorized");
        _;
    }

    function registerDID() external {
        require(!identities[msg.sender].isRegistered, "DID already registered");
        identities[msg.sender].isRegistered = true;
        emit DIDRegistered(msg.sender);
    }

    function setCredentials(
        address user,
        string memory skill,
        string memory university,
        uint256 reputation
        // Add more fields as needed
    ) external onlyAdmin {
        require(identities[user].isRegistered, "User not registered");
        identities[user].skill = skill;
        identities[user].university = university;
        identities[user].reputation = reputation;
        // Set more fields as needed
    }

    function getCredential(address user) external view returns (
        string memory skill,
        string memory university,
        uint256 reputation
        // Add more fields as needed
    ) {
        require(identities[user].isRegistered, "User not registered");
        skill = identities[user].skill;
        university = identities[user].university;
        reputation = identities[user].reputation;
    }

    function grantAdmin(address _admin) external {
        require(!admin[_admin], "Admin already exists");
        admin[_admin] = true;
    }

    function revokeAdmin(address _admin) external onlyAdmin {
        require(admin[_admin], "Admin does not exist");
        admin[_admin] = false;
    }
}


// verified and deployed on address --> 0xE2F9eDFb8D9Ef8fb5f81df1460A3858043815BC1 on Scroll Sepolia Testnet