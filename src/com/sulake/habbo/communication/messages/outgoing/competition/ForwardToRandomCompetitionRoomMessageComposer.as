﻿package com.sulake.habbo.communication.messages.outgoing.competition
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ForwardToRandomCompetitionRoomMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array = [];

        public function ForwardToRandomCompetitionRoomMessageComposer(_arg_1:String)
        {
            this._SafeStr_875.push(_arg_1);
        }

        public function getMessageArray():Array
        {
            return (this._SafeStr_875);
        }

        public function dispose():void
        {
            this._SafeStr_875 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}
