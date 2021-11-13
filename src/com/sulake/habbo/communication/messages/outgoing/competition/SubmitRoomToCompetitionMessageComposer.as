package com.sulake.habbo.communication.messages.outgoing.competition
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SubmitRoomToCompetitionMessageComposer implements IMessageComposer 
    {

        public static const _SafeStr_1872:int = 0;
        public static const _SafeStr_1873:int = 1;
        public static const _SafeStr_1874:int = 2;
        public static const _SafeStr_1875:int = 3;

        private var _SafeStr_690:Array = [];

        public function SubmitRoomToCompetitionMessageComposer(_arg_1:String, _arg_2:int)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }


    }
}

