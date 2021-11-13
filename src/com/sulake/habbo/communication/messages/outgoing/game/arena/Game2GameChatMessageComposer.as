package com.sulake.habbo.communication.messages.outgoing.game.arena
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class Game2GameChatMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1883:String;

        public function Game2GameChatMessageComposer(_arg_1:String)
        {
            _SafeStr_1883 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1883]);
        }

        public function dispose():void
        {
            _SafeStr_1883 = null;
        }


    }
}

