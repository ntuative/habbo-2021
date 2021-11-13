package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FurniRentOrBuyoutOfferMessageParser implements IMessageParser 
    {

        private var _isWallItem:Boolean;
        private var _furniTypeName:String;
        private var _buyout:Boolean;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isWallItem = _arg_1.readBoolean();
            _furniTypeName = _arg_1.readString();
            _buyout = _arg_1.readBoolean();
            _priceInCredits = _arg_1.readInteger();
            _priceInActivityPoints = _arg_1.readInteger();
            _activityPointType = _arg_1.readInteger();
            return (true);
        }

        public function get isWallItem():Boolean
        {
            return (_isWallItem);
        }

        public function get furniTypeName():String
        {
            return (_furniTypeName);
        }

        public function get buyout():Boolean
        {
            return (_buyout);
        }

        public function get priceInCredits():int
        {
            return (_priceInCredits);
        }

        public function get priceInActivityPoints():int
        {
            return (_priceInActivityPoints);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }


    }
}