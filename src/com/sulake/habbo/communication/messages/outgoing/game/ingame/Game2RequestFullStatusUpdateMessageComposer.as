package com.sulake.habbo.communication.messages.outgoing.game.ingame
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class Game2RequestFullStatusUpdateMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function Game2RequestFullStatusUpdateMessageComposer(_arg_1:int)
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

