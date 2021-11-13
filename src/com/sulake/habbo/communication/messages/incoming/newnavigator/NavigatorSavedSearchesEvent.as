package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorSavedSearchesParser;

        public class NavigatorSavedSearchesEvent extends MessageEvent 
    {

        public function NavigatorSavedSearchesEvent(_arg_1:Function)
        {
            super(_arg_1, NavigatorSavedSearchesParser);
        }

        public function getParser():NavigatorSavedSearchesParser
        {
            return (parser as NavigatorSavedSearchesParser);
        }


    }
}