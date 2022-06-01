
pragma solidity ^0.8.0;

contract Test is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    uint256 public LEVEL1_NFT = 100;
    uint256 public LEVEL2_NFT = 100;
    uint256 public LEVEL3_NFT = 100;
    uint256 public LEVEL4_NFT = 100;

    string private _LEVEL1_NFT_BaseURI = "";
    string private _LEVEL2_NFT_BaseURI = "";
    string private _LEVEL3_NFT_BaseURI = "";
    string private _LEVEL4_NFT_BaseURI = "";
  
    string private suffix  = ".json";

    Counters.Counter public _counter_LEVEL1_NFT;
    Counters.Counter public _counter_LEVEL2_NFT;
    Counters.Counter public _counter_LEVEL3_NFT;
    Counters.Counter public _counter_LEVEL4_NFT;
    
    constructor() ERC721("Test", "Test") {
        _counter_LEVEL2_NFT._value = 200;
        _counter_LEVEL3_NFT._value = 300;
        _counter_LEVEL4_NFT._value = 400;

    }


    function setBaseURI(
        string memory LEVEL1_NFT_BaseURI,
        string memory LEVEL2_NFT_BaseURI,
        string memory LEVEL3_NFT_BaseURI,
        string memory LEVEL4_NFT_BaseURI
    ) external onlyOwner {
        _LEVEL1_NFT_BaseURI = LEVEL1_NFT_BaseURI;
        _LEVEL2_NFT_BaseURI = LEVEL2_NFT_BaseURI;
        _LEVEL3_NFT_BaseURI = LEVEL3_NFT_BaseURI;
        _LEVEL4_NFT_BaseURI = LEVEL4_NFT_BaseURI;
    }

    function mint_Level1_NFT()public{
        _counter_LEVEL1_NFT.increment();
        uint256 tokenId = _counter_LEVEL1_NFT.current();

        _safeMint(msg.sender,tokenId);
    }
    
    function mint_Level2_NFT()public{
        _counter_LEVEL2_NFT.increment();
        
        uint256 tokenId = _counter_LEVEL2_NFT.current();
        _safeMint(msg.sender,tokenId);
    }
    
    function mint_Level3_NFT()public{
        _counter_LEVEL3_NFT.increment();
        
        uint256 tokenId = _counter_LEVEL3_NFT.current();
        _safeMint(msg.sender,tokenId);
    }

    function mint_Level4_NFT()public{
        _counter_LEVEL4_NFT.increment();
        
        uint256 tokenId = _counter_LEVEL4_NFT.current();
        _safeMint(msg.sender,tokenId);
    }

    function burn(uint256 tokenId_)external{
        _burn(tokenId_);

            if (tokenId_ >= 0 && tokenId_ <= 100) {
               _counter_LEVEL1_NFT.decrement();
            } else if (tokenId_ > 200 && tokenId_ <= 300) {
                _counter_LEVEL2_NFT.decrement();

            } else if (tokenId_ > 300 && tokenId_ <= 400) {  
                _counter_LEVEL3_NFT.decrement();
            } else if (tokenId_ > 400 && tokenId_ < 501 ) {
                _counter_LEVEL4_NFT.decrement();
            }
    }

    function tokenURI(uint256 tokenId) public view override(ERC721) returns (string memory) {
        require(_exists(tokenId), "Token does not exist");

            if (tokenId >= 0 && tokenId <= 100) {
                return string(abi.encodePacked(_LEVEL1_NFT_BaseURI, tokenId.toString(), suffix));

            } else if (tokenId > 200 && tokenId <= 300) {
                return string(abi.encodePacked(_LEVEL2_NFT_BaseURI, tokenId.toString(), suffix));

            } else if (tokenId > 300 && tokenId <= 400) {
                return string(abi.encodePacked(_LEVEL3_NFT_BaseURI, tokenId.toString(), suffix));

            } else if (tokenId > 400 && tokenId < 501 ) {
                return string(abi.encodePacked(_LEVEL4_NFT_BaseURI, tokenId.toString(), suffix));
                
        }

        return "";
    }

    function totalSupplyOf_L1_NFT() public view returns (uint256) {
        return _counter_LEVEL1_NFT.current();
    }
    
    function totalSupplyOf_L2_NFT() public view returns (uint256) {
        uint256 total =  _counter_LEVEL2_NFT.current();
        return (total - 200);
    }
    
    function totalSupplyOf_L3_NFT() public view returns (uint256) {
        uint256 total =  _counter_LEVEL3_NFT.current();
        return (total - 300);
    }
    
    function totalSupplyOf_L4_NFT() public view returns (uint256) {
        uint256 total =  _counter_LEVEL4_NFT.current();
        return (total - 400);
    }

    function totalSupply()public view override(ERC721Enumerable) returns(uint256) {
        uint256 supplyOfLevel1 = totalSupplyOf_L1_NFT();
        uint256 supplyOfLevel2 = totalSupplyOf_L2_NFT();
        uint256 supplyOfLevel3 = totalSupplyOf_L3_NFT();
        uint256 supplyOfLevel4 = totalSupplyOf_L4_NFT();

        return (supplyOfLevel1 + supplyOfLevel2 + supplyOfLevel3 + supplyOfLevel4);
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;

        payable(msg.sender).transfer(balance);
    }
}
