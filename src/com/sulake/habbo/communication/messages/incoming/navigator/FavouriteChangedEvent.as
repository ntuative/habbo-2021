package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;

        public class FavouriteChangedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FavouriteChangedEvent(_arg_1:Function)
        {
            super(_arg_1, FavouriteChangedMessageParser);
        }

        public function getParser():FavouriteChangedMessageParser
        {
            return (this._SafeStr_816 as FavouriteChangedMessageParser);
        }


    }
}

