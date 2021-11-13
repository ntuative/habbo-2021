package com.sulake.habbo.communication.messages.parser.avatar
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CheckUserNameResultMessageParser implements IMessageParser 
    {

        private var _resultCode:int = -1;
        private var _name:String;
        private var _nameSuggestions:Array;


        public function get resultCode():int
        {
            return (_resultCode);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get nameSuggestions():Array
        {
            return (_nameSuggestions);
        }

        public function flush():Boolean
        {
            _resultCode = -1;
            _name = "";
            _nameSuggestions = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _resultCode = _arg_1.readInteger();
            _name = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _nameSuggestions = [];
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _nameSuggestions.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }


    }
}