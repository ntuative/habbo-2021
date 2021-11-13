package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class InstantMessageErrorMessageParser implements IMessageParser 
    {

        private var _SafeStr_776:int;
        private var _SafeStr_1887:int;
        private var _SafeStr_835:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._SafeStr_776 = _arg_1.readInteger();
            this._SafeStr_1887 = _arg_1.readInteger();
            this._SafeStr_835 = _arg_1.readString();
            return (true);
        }

        public function get errorCode():int
        {
            return (this._SafeStr_776);
        }

        public function get userId():int
        {
            return (this._SafeStr_1887);
        }

        public function get message():String
        {
            return (this._SafeStr_835);
        }


    }
}

