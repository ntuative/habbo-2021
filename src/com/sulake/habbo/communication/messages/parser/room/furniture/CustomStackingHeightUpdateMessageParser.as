package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CustomStackingHeightUpdateMessageParser implements IMessageParser 
    {

        private var _furniId:int;
        private var _height:Number;


        public function flush():Boolean
        {
            _furniId = -1;
            _height = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _furniId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _height = (_local_2 / 100);
            return (true);
        }

        public function get height():Number
        {
            return (_height);
        }

        public function get furniId():int
        {
            return (_furniId);
        }


    }
}