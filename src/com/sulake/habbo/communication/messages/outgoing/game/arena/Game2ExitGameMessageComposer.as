package com.sulake.habbo.communication.messages.outgoing.game.arena
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class Game2ExitGameMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1882:Boolean;

        public function Game2ExitGameMessageComposer(_arg_1:Boolean=true)
        {
            _SafeStr_1882 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1882]);
        }

        public function dispose():void
        {
        }


    }
}

