package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NoobnessLevelMessageEventMessageParser implements IMessageParser 
    {

        private var _noobnessLevel:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _noobnessLevel = _arg_1.readInteger();
            return (true);
        }

        public function get noobnessLevel():int
        {
            return (_noobnessLevel);
        }


    }
}