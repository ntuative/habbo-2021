package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.SpecialRoomEffectMessageParser;

        public class SpecialRoomEffectMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SpecialRoomEffectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SpecialRoomEffectMessageParser);
        }

    }
}