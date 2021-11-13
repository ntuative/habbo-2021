package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.utils.FriendlyTime;
    import flash.events.Event;

    public class _SafeStr_192 extends TriggerPeriodically 
    {


        override public function get code():int
        {
            return (_SafeStr_194.PERIODIC_LONG);
        }

        override protected function onSliderChange(_arg_1:Event):void
        {
            var _local_2:SliderWindowController;
            var _local_4:Number;
            var _local_3:String;
            if (_arg_1.type == "change")
            {
                _local_2 = (_arg_1.target as SliderWindowController);
                if (_local_2)
                {
                    _local_4 = _local_2.getValue();
                    _local_3 = FriendlyTime.getFriendlyTime(roomEvents.localization, (_local_4 * 5));
                    roomEvents.localization.registerParameter("wiredfurni.params.setlongtime", "time", _local_3);
                };
            };
        }


    }
}

