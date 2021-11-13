package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorLiftedRoomsParser;

        public class NavigatorLiftedRoomsEvent extends MessageEvent 
    {

        public function NavigatorLiftedRoomsEvent(_arg_1:Function)
        {
            super(_arg_1, NavigatorLiftedRoomsParser);
        }

        public function getParser():NavigatorLiftedRoomsParser
        {
            return (parser as NavigatorLiftedRoomsParser);
        }


    }
}