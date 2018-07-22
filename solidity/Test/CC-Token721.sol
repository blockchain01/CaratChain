pragma solidity ^0.4.24;



import "./CC-Rules.sol";  


//InterfaceERC-20合約
interface InterfaceTocontract {
  function balance(address _myAddress) public view returns (uint);
  function burn(uint256 _value) public returns (bool success);
}

//外部使用受權
interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }




//本合約
contract caratchainTokenERC721 is BasicRules {


//記錄舊合約地址  
  address InterfaceToAdd = 0x72a9AB77a54461AC1b30A788a8F969cd56ef11b3;
  InterfaceTocontract ToThisContract = InterfaceTocontract(InterfaceToAdd);

///////////////////////////////////////////////////////////////////////// event

//轉帳時通知區塊
    event Transfer(address indexed from, address indexed to, uint256 value);
    
//受權時通知區塊
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

//燒毀時通知區塊
    event Burn(address indexed from, uint256 value);
    
////////////////////////////////////////////////////////////////////////基本資料

//名,符號,小數,總量
    string public name;
    string public symbol;
    uint8 public decimals = 0;
    uint256 public totalSupply;
    
////////////////////////////////////////////////////////////////////////個人資料

//戶口
    mapping (address => uint256) public balanceOf;

//獨立網址
    mapping (address => string) public CCindex;
    
//受權額度  
    mapping (address => mapping (address => uint256)) public allowance;



//新增代幣
  function making721(string index) external payable{
    //入帳給owner  
    owner.transfer(msg.value);
    //驗證價格  
    require(msg.value > Price || msg.value == Price);  
    //進入內部功能-新增代幣
    NewToken(msg.sender,index,msg.value);

  }


  function NewToken(address _A,string _I,uint _V) private{



  }


  function exchange721() public view returns (uint num) {

//重點//重點//重點//重點//重點//重點//重點//重點//重點//重點
//ToThisContract.舊約功能名(拿這個ADD入去);//uint num = 將舊約的數據,記在本功能
    uint num = ToThisContract.getNum(msg.sender);
//重點//重點//重點//重點//重點//重點//重點//重點//重點//重點

//return唔洗解吧
    return num;

  }
}


