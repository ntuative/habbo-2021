package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveParser;

        public class FurniListRemoveEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListRemoveEvent(_arg_1:Function)
        {
            super(_arg_1, FurniListRemoveParser);
        }

        public function getParser():FurniListRemoveParser
        {
            return (this._SafeStr_816 as FurniListRemoveParser);
        }


    }
}

