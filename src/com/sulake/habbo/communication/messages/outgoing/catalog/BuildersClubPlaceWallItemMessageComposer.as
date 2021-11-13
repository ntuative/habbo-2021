package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class BuildersClubPlaceWallItemMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function BuildersClubPlaceWallItemMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String)
        {
            _SafeStr_690 = [_arg_1, _arg_2, _arg_3, _arg_4];
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

