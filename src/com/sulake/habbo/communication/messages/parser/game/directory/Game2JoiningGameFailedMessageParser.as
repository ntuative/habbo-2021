package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2JoiningGameFailedMessageParser implements IMessageParser 
    {

        public static const _SafeStr_1989:int = 1;
        public static const _SafeStr_1990:int = 2;
        public static const _SafeStr_1991:int = 3;
        public static const _SafeStr_1992:int = 4;
        public static const _SafeStr_1993:int = 5;
        public static const _SafeStr_1994:int = 6;
        public static const _SafeStr_1995:int = 7;
        public static const _SafeStr_1996:int = 8;

        private var _reason:int;


        public function get reason():int
        {
            return (_reason);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _reason = _arg_1.readInteger();
            return (true);
        }


    }
}

