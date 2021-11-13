package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetGuildMembersMessageComposer implements IMessageComposer 
    {

        public static const _SafeStr_1950:int = 0;
        public static const _SafeStr_1951:int = 1;
        public static const _SafeStr_1952:int = 2;

        private var _SafeStr_690:Array = [];

        public function GetGuildMembersMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
            _SafeStr_690.push(_arg_3);
            _SafeStr_690.push(_arg_4);
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

