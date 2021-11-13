package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.CompetitionRoomsDataMessageParser;

        public class CompetitionRoomsDataMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CompetitionRoomsDataMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CompetitionRoomsDataMessageParser);
        }

        public function getParser():CompetitionRoomsDataMessageParser
        {
            return (this._SafeStr_816 as CompetitionRoomsDataMessageParser);
        }


    }
}

