package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GetForumsListMessageParser implements IMessageParser 
    {

        private var _listCode:int;
        private var _totalAmount:int;
        private var _startIndex:int;
        private var _amount:int;
        private var _forums:Array;


        public function get listCode():int
        {
            return (_listCode);
        }

        public function get totalAmount():int
        {
            return (_totalAmount);
        }

        public function get startIndex():int
        {
            return (_startIndex);
        }

        public function get amount():int
        {
            return (_amount);
        }

        public function get forums():Array
        {
            return (_forums);
        }

        public function flush():Boolean
        {
            _forums = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _listCode = _arg_1.readInteger();
            _totalAmount = _arg_1.readInteger();
            _startIndex = _arg_1.readInteger();
            _amount = _arg_1.readInteger();
            _forums = [];
            _local_2 = 0;
            while (_local_2 < amount)
            {
                _forums.push(ForumData.readFromMessage(_arg_1));
                _local_2++;
            };
            return (true);
        }


    }
}