package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetYoutubeDisplayPlaylistMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array;

        public function SetYoutubeDisplayPlaylistMessageComposer(_arg_1:int, _arg_2:String)
        {
            _SafeStr_875 = [_arg_1, _arg_2];
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }

        public function dispose():void
        {
            _SafeStr_875 = null;
        }


    }
}

