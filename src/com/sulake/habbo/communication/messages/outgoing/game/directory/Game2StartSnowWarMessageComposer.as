package com.sulake.habbo.communication.messages.outgoing.game.directory
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class Game2StartSnowWarMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function Game2StartSnowWarMessageComposer(_arg_1:String)
        {
            _SafeStr_690.push(_arg_1);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = [];
        }


    }
}

