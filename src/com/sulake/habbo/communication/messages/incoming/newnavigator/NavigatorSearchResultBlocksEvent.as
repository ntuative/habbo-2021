package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorSearchResultBlocksParser;

        public class NavigatorSearchResultBlocksEvent extends MessageEvent 
    {

        public function NavigatorSearchResultBlocksEvent(_arg_1:Function)
        {
            super(_arg_1, NavigatorSearchResultBlocksParser);
        }

        public function getParser():NavigatorSearchResultBlocksParser
        {
            return (parser as NavigatorSearchResultBlocksParser);
        }


    }
}