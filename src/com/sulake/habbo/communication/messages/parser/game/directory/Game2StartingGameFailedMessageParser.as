package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2StartingGameFailedMessageParser implements IMessageParser 
    {

        public static const _SafeStr_1997:int = 1;
        public static const _SafeStr_1998:int = 2;

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

