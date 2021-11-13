package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.PopularRoomTagsResultMessageParser;

        public class PopularRoomTagsResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function PopularRoomTagsResultEvent(_arg_1:Function)
        {
            super(_arg_1, PopularRoomTagsResultMessageParser);
        }

        public function getParser():PopularRoomTagsResultMessageParser
        {
            return (this._SafeStr_816 as PopularRoomTagsResultMessageParser);
        }


    }
}

