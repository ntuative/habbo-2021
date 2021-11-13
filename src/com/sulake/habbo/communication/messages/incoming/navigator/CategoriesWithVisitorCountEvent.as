package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.CategoriesWithVisitorCountParser;

        public class CategoriesWithVisitorCountEvent extends MessageEvent implements IMessageEvent 
    {

        public function CategoriesWithVisitorCountEvent(_arg_1:Function)
        {
            super(_arg_1, CategoriesWithVisitorCountParser);
        }

        public function getParser():CategoriesWithVisitorCountParser
        {
            return (this._SafeStr_816 as CategoriesWithVisitorCountParser);
        }


    }
}

