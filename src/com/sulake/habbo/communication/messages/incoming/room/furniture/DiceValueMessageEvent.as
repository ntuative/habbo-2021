package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DiceValueMessageParser;

        public class DiceValueMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function DiceValueMessageEvent(_arg_1:Function)
        {
            super(_arg_1, DiceValueMessageParser);
        }

        public function getParser():DiceValueMessageParser
        {
            return (_SafeStr_816 as DiceValueMessageParser);
        }


    }
}

