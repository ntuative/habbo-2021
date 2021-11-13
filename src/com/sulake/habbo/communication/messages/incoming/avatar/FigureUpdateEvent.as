package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.FigureUpdateParser;

        public class FigureUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FigureUpdateEvent(_arg_1:Function)
        {
            super(_arg_1, FigureUpdateParser);
        }

        private function getParser():FigureUpdateParser
        {
            return (this._SafeStr_816 as FigureUpdateParser);
        }

        public function get figure():String
        {
            return ((_SafeStr_816 as FigureUpdateParser).figure);
        }

        public function get gender():String
        {
            return ((_SafeStr_816 as FigureUpdateParser).gender);
        }


    }
}

