package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;

        public class FavouritesEvent extends MessageEvent implements IMessageEvent 
    {

        public function FavouritesEvent(_arg_1:Function)
        {
            super(_arg_1, FavouritesMessageParser);
        }

        public function getParser():FavouritesMessageParser
        {
            return (this._SafeStr_816 as FavouritesMessageParser);
        }


    }
}

