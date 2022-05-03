// SPDX-License-Identifier: MIT;
pragma solidity 0.8.13;
contract ZombieFactory {
    event NewZombie(uint256 zombieId, string _name, uint256 dna);
    uint256 dnaDigit = 16;
    uint256 dnaModulus = 10**dnaDigit;
    struct Zombie {
        string name;
        uint256 dna;
    }
    Zombie[] public zombieArr;
    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) private {
        uint id = zombieArr.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint256 randomDna = _generateRandomDna(_name);
        _createZombie(_name, randomDna);
    }
}
