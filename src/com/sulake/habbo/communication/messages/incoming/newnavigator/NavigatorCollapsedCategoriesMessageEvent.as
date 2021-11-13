package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.newnavigator.CollapsedCategoriesMessageParser;

        public class NavigatorCollapsedCategoriesMessageEvent extends MessageEvent 
    {

        public function NavigatorCollapsedCategoriesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CollapsedCategoriesMessageParser);
        }

        public function getParser():CollapsedCategoriesMessageParser
        {
            return (parser as CollapsedCategoriesMessageParser);
        }


    }
}