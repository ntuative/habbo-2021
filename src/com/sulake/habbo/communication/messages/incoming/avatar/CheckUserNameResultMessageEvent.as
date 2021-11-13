package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;

        public class CheckUserNameResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static var _SafeStr_505:int = 0;
        public static var _SafeStr_635:int = 1;
        public static var _SafeStr_637:int = 2;
        public static var _SafeStr_636:int = 3;
        public static var _SafeStr_634:int = 4;
        public static var _SafeStr_633:int = 5;

        public function CheckUserNameResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CheckUserNameResultMessageParser);
        }

        public function getParser():CheckUserNameResultMessageParser
        {
            return (_SafeStr_816 as CheckUserNameResultMessageParser);
        }


    }
}

