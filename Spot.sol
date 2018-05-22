pragma solidity ^0.4.19;

contract ThreeDParkSpot{
    struct Spot{
        address wallet;
        string name;
        string direction;
    }
    
    struct Reservation{
        address client;
        string from;
        string to;
        uint value;
    }
    
    mapping(uint => Reservation) public reservations;
    uint public reservationsSize;
    
    Spot public owner;
    
    constructor(string _name, string _direction) payable public{
        owner = Spot(msg.sender,_name,_direction);
        reservationsSize = 0;
    }
    
    function reserveSpot(address _client,string _from, string _to) public payable {
        reservations[reservationsSize] = Reservation(_client,_from,_to,msg.value);
        reservationsSize = reservationsSize + 1;
    }
    
    function getBalance() public view returns(uint balance){
        return(address(this).balance);
    }
    
    function withdraw() public {
        owner.wallet.transfer(getBalance());
    }
    
}
