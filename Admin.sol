pragma solidity ^0.4.19;

contract ThreeDParkSpot {
    function owner() pure public returns(address ,string ,string ) {}
    function reserveSpot(address ,string , string ) public payable {}
}

contract ThreeDParkAdmin {
    
    struct Spot {
        string owner;
        string direction;
        string added;
    }
    mapping(address => Spot) public spots;
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function addSpot(address newSpot,string added) public {
        require(msg.sender == owner);
        ThreeDParkSpot spot = ThreeDParkSpot(newSpot);
        address _wallet;
        string memory _owner;
        string memory _direction;
        (_wallet,_owner,_direction) = spot.owner();
        spots[newSpot] = Spot(_owner,_direction,added);
    }
    
    function reserveSpot(address _spot,address _client,string _from, string _to) public payable {
        require(msg.sender == owner);
        uint transfer = msg.value - (msg.value / 10);
        ThreeDParkSpot spot = ThreeDParkSpot(_spot);
        spot.reserveSpot.value(transfer)(_client,_from,_to);
    }
    
    function getBalance() public view returns(uint balance){
        require(msg.sender == owner);
        return address(this).balance;
    }
    
}
