package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2EnterArenaFailedMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2000:int = 1;
        public static const _SafeStr_2001:int = 2;
        public static const _SafeStr_2002:int = 3;
        public static const _SafeStr_2003:int = 4;

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

