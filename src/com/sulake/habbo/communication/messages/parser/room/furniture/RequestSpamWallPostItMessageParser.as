package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RequestSpamWallPostItMessageParser implements IMessageParser 
    {

        private var _itemId:int;
        private var _location:String;


        public function get itemId():int
        {
            return (_itemId);
        }

        public function get location():String
        {
            return (_location);
        }

        public function flush():Boolean
        {
            _itemId = -1;
            _location = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _itemId = _arg_1.readInteger();
            _location = _arg_1.readString();
            return (true);
        }


    }
}