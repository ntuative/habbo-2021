package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MessengerErrorMessageParser implements IMessageParser 
    {

        private var _SafeStr_1978:int;
        private var _SafeStr_776:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._SafeStr_1978 = _arg_1.readInteger();
            this._SafeStr_776 = _arg_1.readInteger();
            return (true);
        }

        public function get clientMessageId():int
        {
            return (this._SafeStr_1978);
        }

        public function get errorCode():int
        {
            return (this._SafeStr_776);
        }


    }
}

