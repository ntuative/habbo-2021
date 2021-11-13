package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import flash.events.Event;

    public class TriggerPeriodically extends DefaultTriggerConf 
    {

        private var _roomEvents:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;


        override public function get code():int
        {
            return (_SafeStr_194.TRIGGER_PERIODICALLY);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(_slider.getValue());
            return (_local_2);
        }

        override public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            _roomEvents = _arg_2;
            _slider = new SliderWindowController(_arg_2, getInput(_arg_1), _arg_2.assets, 1, 120, 1);
            _slider.setValue(1);
            _slider.addEventListener("change", onSliderChange);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_3:int = _arg_2.intParams[0];
            _slider.setValue(_local_3);
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(_arg_1:IWindowContainer):IWindowContainer
        {
            return (_arg_1.findChildByName("slider_container") as IWindowContainer);
        }

        protected function onSliderChange(_arg_1:Event):void
        {
            var _local_2:SliderWindowController;
            var _local_5:Number;
            var _local_4:int;
            var _local_3:String;
            if (_arg_1.type == "change")
            {
                _local_2 = (_arg_1.target as SliderWindowController);
                if (_local_2)
                {
                    _local_5 = _local_2.getValue();
                    _local_4 = _local_5;
                    _local_3 = TriggerOnce.getSecsFromPulses(_local_4);
                    _roomEvents.localization.registerParameter("wiredfurni.params.settime", "seconds", _local_3);
                };
            };
        }

        protected function get roomEvents():HabboUserDefinedRoomEvents
        {
            return (_roomEvents);
        }

        public function get slider():SliderWindowController
        {
            return (_slider);
        }


    }
}

