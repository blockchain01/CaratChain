// 0x4d431a9871527ea30f0d99ef85d9561c64f51999


//版本聲明
pragma solidity ^0.4.24;

//外部使用受權
interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }


/////////////////////////////////////////////////////////////////設定合約持有人
contract SetOwner{ 
//合約持有人地址
    address public owner;

    function SetOwner() { 
//初始設定合約持有人  
        owner = msg.sender;
    }
}


/////////////////////////////////////////////////////////////////////////規則
contract BasicRules is SetOwner{

//驗證持有人,不是持有人則消耗GAS但取消所有動作
 modifier JustOwner() {assert(msg.sender == owner);  _;}
    
//新Owner不能是0,是0則取消所有動作
 modifier AddRrule(address _T) {require(address(0x0) != _T);  _;}
 
}



/////////////////////////////////////////////////////////////持有人修改合約資料
contract Admin is BasicRules {

//修改-合約持有人 
function ChangeOwner(address NewOwner) 
//新Owner不能是0
JustOwner AddRrule(NewOwner) public
returns (bool success){
//Owner=新Owner
owner = NewOwner;
return true; //成功通知
}


}




//合約開始
contract caratchainTokenERC20 is Admin {
    

///////////////////////////////////////////////////////////////////////// event

//轉帳時通知區塊
    event Transfer(address indexed from, address indexed to, uint256 value);
    
//受權時通知區塊
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

//燒毀時通知區塊
    event Burn(address indexed from, uint256 value);
    
    
////////////////////////////////////////////////////////////////////////基本資料


//名,符號,小數,總量
    string public name = "Carat Chain";
    string public symbol = "CRT" ;
    uint8 public decimals = 0;
    uint256 public totalSupply = 119800000;
    
    
// 免費代幣用資料
   uint public FreeGetimit = 200000;   // 免費代幣上限
   uint public FreeGetVol = 100; // 單個賬戶獲取代幣數量
   uint public FreeGetped = 0; // 已派發免費代幣数量

////////////////////////////////////////////////////////////////////////個人資料

//戶口
   mapping (address => uint256) public balanceOf;

//已接受免費代幣的戶口
   mapping(address => bool) public priorityClient;
   
//受權額度  
    mapping (address => mapping (address => uint256)) public allowance;

////////////////////////////////////////////////////////////////////////合約功能



//合約初始化
    function caratchainTokenERC20() public {
        //初始發代幣全數給發行者
        balanceOf[msg.sender] = totalSupply;     
        //成為已接受免費獲取的戶口
        priorityClient[msg.sender] = true;
    }


//免費獲取代幣
  function FreeGetToken(address client) public payable {
    //入帳給owner  
    owner.transfer(msg.value);
    //驗證:未接受免費代幣||免費代幣未派完,不符則取消所有動作
    require(priorityClient[client] != true && FreeGetped < FreeGetimit);
    //成為已接受免費獲取的戶口
        priorityClient[client] = true;
    //已派發免費代幣数量+單個戶口免費獲取代幣數量
        FreeGetped += FreeGetVol;
    //代幣發行量+單個戶口免費獲取代幣數量
        totalSupply += FreeGetVol;
    // 戶口+單個戶口免費獲取代幣數量   
        balanceOf[client] += FreeGetVol;
  }



//轉帳
    function transfer(
        address _to,      //收帳人
        uint256 _value    //轉帳額
    ) public returns (bool success) {
//轉帳時的數據進入內部功能
        _transfer(msg.sender, _to, _value);
        return true;      //成功通知
    }
    

    
//銷毀TOKEN
    function burn(uint256 _value) public returns (bool success) {
//銷毀量少於戶口現有額
        require(balanceOf[msg.sender] >= _value); 
//在我的戶口中銷毀
        balanceOf[msg.sender] -= _value;  
//在總量中減少
        totalSupply -= _value; 
//燒毀時通知區塊
        emit Burn(msg.sender, _value);
        return true;  //成功通知
    }
    

    
//受權額度給其他人
    function approve(
        address _spender, //被受權者戶口
        uint256 _value    //受權額
    ) public
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;  //記錄受權額
        emit Approval(msg.sender, _spender, _value);  //受權時通知區塊
        return true;   //成功通知
    }



//受權額度轉帳
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
//轉帳額少於受權額度
        require(_value <= allowance[_from][msg.sender]);
//受權轉帳額度減轉帳額
        allowance[_from][msg.sender] -= _value;
//轉帳時的數據進入內部功能
        _transfer(_from, _to, _value);
        return true;     //成功通知
    }
    
    
//在其他DAPP顯示
    function approveAndCall(
        address _spender,  //被受權者戶口
        uint256 _value,    //受權額
        bytes _extraData   //受權者留言
    ) public
        returns (bool success) {
//被受權者戶口可在其他DAPP使用
        tokenRecipient spender = tokenRecipient(_spender);
//如果有被受權
        if (approve(_spender, _value)) {
//將資料記錄在被受權者戶口(受權者'我',受權額,本合約地址,受權者留言)
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true; //成功通知
        }
    }


////////////////////////////////////////////////////////////////////////內部功能


//轉帳時的內部功能
    function _transfer(address _from, address _to, uint _value) internal {
//防止轉到地址0
    require(_to != address(0x0));
//轉帳額少於戶口現有額
        require(balanceOf[_from] >= _value);
//收帳後必須大於收帳前
        require(balanceOf[_to] + _value >= balanceOf[_to]);
// 發送者戶口+收帳戶口額量,用於比較結果
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
// 發送者戶減少發送量
        balanceOf[_from] -= _value;
// 收帳戶戶堵增加發送量
        balanceOf[_to] += _value;
// 轉帳時通知區塊    
        emit Transfer(_from, _to, _value);
//轉帳完成比較previousBalances,如不同則消耗GAS但取消所有轉帳動作
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }



}
