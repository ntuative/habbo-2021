package com.sulake.habbo.communication.messages.outgoing.campaign
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class OpenCampaignCalendarDoorAsStaffComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function OpenCampaignCalendarDoorAsStaffComposer(_arg_1:String, _arg_2:int)
        {
            _SafeStr_875.push(_arg_1);
            _SafeStr_875.push(_arg_2);
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

