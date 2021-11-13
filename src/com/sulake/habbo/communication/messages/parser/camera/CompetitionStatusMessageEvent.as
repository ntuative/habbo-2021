package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class CompetitionStatusMessageEvent extends MessageEvent 
    {

        public function CompetitionStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CompetitionStatusMessageParser);
        }

        public function getParser():CompetitionStatusMessageParser
        {
            return (this._SafeStr_816 as CompetitionStatusMessageParser);
        }


    }
}

