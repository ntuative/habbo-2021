package com.sulake.core.communication.messages
{
    import com.sulake.core.communication.connection.IConnection;

    public class MessageEvent implements IMessageEvent 
    {

        protected var _callback:Function;
        protected var _connection:IConnection;
        private var _parserClass:Class;
        protected var _SafeStr_816:IMessageParser;

        public function MessageEvent(_arg_1:Function, _arg_2:Class)
        {
            _callback = _arg_1;
            _parserClass = _arg_2;
        }

        public function dispose():void
        {
            _callback = null;
            _parserClass = null;
            _connection = null;
            _SafeStr_816 = null;
        }

        public function get callback():Function
        {
            return (_callback);
        }

        public function set connection(_arg_1:IConnection):void
        {
            _connection = _arg_1;
        }

        public function get connection():IConnection
        {
            return (_connection);
        }

        public function get parserClass():Class
        {
            return (_parserClass);
        }

        public function get parser():IMessageParser
        {
            return (_SafeStr_816);
        }

        public function set parser(_arg_1:IMessageParser):void
        {
            _SafeStr_816 = _arg_1;
        }


    }
}

