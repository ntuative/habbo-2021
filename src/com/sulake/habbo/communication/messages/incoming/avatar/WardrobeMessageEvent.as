package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.WardrobeMessageParser;

        public class WardrobeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static const _SafeStr_1706:int = 0;
        public static const _SafeStr_1707:int = 1;

        public function WardrobeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, WardrobeMessageParser);
        }

        private function getParser():WardrobeMessageParser
        {
            return (this._SafeStr_816 as WardrobeMessageParser);
        }

        public function get outfits():Array
        {
            return (getParser().outfits);
        }

        public function get state():int
        {
            return (getParser().state);
        }


    }
}

