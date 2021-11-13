package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BuildersClubFurniCountMessageParser implements IMessageParser 
    {

        private var _furniCount:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _furniCount = _arg_1.readInteger();
            return (true);
        }

        public function get furniCount():int
        {
            return (_furniCount);
        }


    }
}