SPDX-Licence-Identifier Unlicensed
pragma solidity ^0.8.0;

contract deneme{


    enum Status{
            alindi,
            hazirlaniyor,
            paketlendi,
            yolda
    }

    struct Order{
        address musteri;
        string zipkodu;
        uint256[] products;
        Status status;
    }



    Order[] public orders;
    address public owner;

    constructor(){
        owner=msg.sender;
    }

    function createOrder(string memory _zipCode, uint256[] memory _products) external returns(uint256){
        require(_products.length  0, No products.);

        Order memory order;

        order.musteri = msg.sender;
        order.zipkodu = _zipCode;
        order.products = _products;
        order.status = Status.alindi;
        orders.push(order);
        return orders.length - 1;

    }


    function advancedOrder(uint256 _orderId)  external{

        require(msg.sender==owner,you are not REAL owner);
        require(_orderIdorders.length,Not a valid order id.);

        Order storage order = orders[_orderId];

        require(order.status != Status.alindi, Order is already shipped.);

        if (order.status == Status.alindi) {
            order.status = Status.hazirlaniyor;
        } else if (order.status == Status.hazirlaniyor) {
            order.status = Status.paketlendi;
        } else if (order.status == Status.paketlendi) {
            order.status = Status.yolda;
        }




    }

    function getOrder(uint256 _orderId) external view returns(Order memory){
        require(_orderId  orders.length, Not a valid order id.);
        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) external {
        require(_orderId  orders.length, Not a valid order id.);
        Order storage order = orders[_orderId];
        require(order.musteri == msg.sender, You are not the owner of the order.);
        order.zipkodu = _zip;
    }



}
















