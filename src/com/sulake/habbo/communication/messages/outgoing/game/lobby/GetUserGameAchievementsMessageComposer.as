package com.sulake.habbo.communication.messages.outgoing.game.lobby
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetUserGameAchievementsMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1884:int;

        public function GetUserGameAchievementsMessageComposer(_arg_1:int)
        {
            _SafeStr_1884 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1884]);
        }

        public function dispose():void
        {
        }


    }
}

