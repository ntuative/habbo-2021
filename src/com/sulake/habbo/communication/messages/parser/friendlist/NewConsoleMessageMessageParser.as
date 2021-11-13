package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NewConsoleMessageMessageParser implements IMessageParser 
    {

        private var _SafeStr_1721:int;
        private var _SafeStr_1982:String;
        private var _secondsSinceSent:int;
        private var _extraData:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._SafeStr_1721 = _arg_1.readInteger();
            this._SafeStr_1982 = _arg_1.readString();
            this._secondsSinceSent = _arg_1.readInteger();
            if (_arg_1.bytesAvailable)
            {
                this._extraData = _arg_1.readString();
            };
            return (true);
        }

        public function get senderId():int
        {
            return (this._SafeStr_1721);
        }

        public function get messageText():String
        {
            return (this._SafeStr_1982);
        }

        public function get secondsSinceSent():int
        {
            return (_secondsSinceSent);
        }

        public function get extraData():String
        {
            return (_extraData);
        }


    }
}

