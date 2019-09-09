pragma solidity ^0.4.25;

contract Lottery {
    address public manager;
    address[] public players;
    
    constructor() public {
        manager = msg.sender;
    }
    
    function enter() public payable { // funkcja wprowadzająca gracza do loterii. wjazd od 0.01 ethera
        require(msg.value > .01 ether);
        
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) { // funkcja generująca "liczbę losową", biorąca pod uwagę trudność obecnego bloku, czas oraz liczbę graczy
        return uint(keccak256(block.difficulty, now, players));
    }
    
    function pickWinner() public restricted { // funkcja wybierająca zwycięzcę. tylko twórca kontraktu może ją wywołać
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }
    
    modifier restricted() { // j.w - tylko twórca kontraktu może wywołać funkcję wybierającą zwycięzcę
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address[]) { // zwraca listę wszystkich graczy w grze
        return players;
    }
}