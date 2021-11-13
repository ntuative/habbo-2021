package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FurniListRemoveParser implements IMessageParser 
    {

        private var _stripId:int;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _stripId = _arg_1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get stripId():int
        {
            return (_stripId);
        }


    }
}