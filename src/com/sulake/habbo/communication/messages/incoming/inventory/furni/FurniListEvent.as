package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListParser;

        public class FurniListEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListEvent(_arg_1:Function)
        {
            super(_arg_1, FurniListParser);
        }

        public function getParser():FurniListParser
        {
            return (this._SafeStr_816 as FurniListParser);
        }


    }
}

