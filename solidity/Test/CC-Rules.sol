//版本聲明
pragma solidity ^0.4.24;



/////////////////////////////////////////////////////////////////設定合約持有人
contract SetOwner{ 
//合約持有人地址
    address public owner;
//購買721價格 以SZABO計算,1000000SZABO=1Ether  
    uint Price = 3000 szabo; 
//初始發設定合約持有人    
    function SetOwner() { owner = msg.sender;}
    
}

contract BasicRules is SetOwner{
//驗證持有人,不是持有人則消耗GAS但取消所有動作
    modifier JustOwner() {assert(msg.sender == owner);  _;}
    
//新Owner不能是0,是0則取消所有動作
 modifier AddRrule(address _T) {require(address(0x0) != _T);  _;}   
}


/////////////////////////////////////////////////////////////持有人修改合約資料
contract Admin is BasicRules {


//修改-購買721價格 以SZABO計算,1000000SZABO=1Ether     
function ChangePrice(uint InputPrice) 
//驗證持有人
JustOwner public{
//價格=新價格 以SZABO計算,1000000SZABO=1Ether    
         Price = (InputPrice * 1 szabo);
    }


//修改-合約持有人 
function ChangeAdmin(address NewOwner) 
//新Owner不能是0
JustOwner AddRrule(NewOwner) public{
//Owner=新Owner
         owner = NewOwner;
    }
    
}




