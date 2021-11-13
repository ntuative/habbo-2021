package com.sulake.habbo.communication.messages.parser.advertisement
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomAdErrorMessageParser implements IMessageParser 
    {

        private var _errorCode:int = 0;
        private var _filteredText:String;


        public function get errorCode():int
        {
            return (_errorCode);
        }

        public function get filteredText():String
        {
            return (_filteredText);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _errorCode = _arg_1.readInteger();
            _filteredText = _arg_1.readString();
            return (true);
        }


    }
}