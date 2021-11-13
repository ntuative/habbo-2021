package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FavouriteMembershipUpdateMessageParser implements IMessageParser 
    {

        private var _roomIndex:int;
        private var _habboGroupId:int;
        private var _status:int;
        private var _habboGroupName:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomIndex = _arg_1.readInteger();
            _habboGroupId = _arg_1.readInteger();
            _status = _arg_1.readInteger();
            _habboGroupName = _arg_1.readString();
            return (true);
        }

        public function get roomIndex():int
        {
            return (_roomIndex);
        }

        public function get habboGroupId():int
        {
            return (_habboGroupId);
        }

        public function get status():int
        {
            return (_status);
        }

        public function get habboGroupName():String
        {
            return (_habboGroupName);
        }


    }
}