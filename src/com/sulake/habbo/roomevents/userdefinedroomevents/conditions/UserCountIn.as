package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import flash.events.Event;

    public class UserCountIn extends DefaultConditionType 
    {

        private var _roomEvents:HabboUserDefinedRoomEvents;
        private var _SafeStr_3671:SliderWindowController;
        private var _SafeStr_3672:SliderWindowController;


        override public function get code():int
        {
            return (_SafeStr_228.USER_COUNT_IN);
        }

        override public function get negativeCode():int
        {
            return (_SafeStr_228.NOT_USER_COUNT_IN);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(_SafeStr_3671.getValue());
            _local_2.push(_SafeStr_3672.getValue());
            return (_local_2);
        }

        override public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            _roomEvents = _arg_2;
            _SafeStr_3671 = new SliderWindowController(_arg_2, getMinInput(_arg_1), _arg_2.assets, 1, 50, 1);
            _SafeStr_3671.addEventListener("change", onMinSliderChange);
            _SafeStr_3671.setValue(1);
            _SafeStr_3672 = new SliderWindowController(_arg_2, getMaxInput(_arg_1), _arg_2.assets, 1, 50, 1);
            _SafeStr_3672.addEventListener("change", onMaxSliderChange);
            _SafeStr_3672.setValue(50);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_3:int = _arg_2.intParams[0];
            var _local_4:int = _arg_2.intParams[1];
            _SafeStr_3671.setValue(_local_3);
            _SafeStr_3672.setValue(_local_4);
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getMinInput(_arg_1:IWindowContainer):IWindowContainer
        {
            return (_arg_1.findChildByName("min_slider_container") as IWindowContainer);
        }

        private function getMaxInput(_arg_1:IWindowContainer):IWindowContainer
        {
            return (_arg_1.findChildByName("max_slider_container") as IWindowContainer);
        }

        private function onMinSliderChange(_arg_1:Event):void
        {
            var _local_2:SliderWindowController;
            var _local_3:Number;
            var _local_4:int;
            if (_arg_1.type == "change")
            {
                _local_2 = (_arg_1.target as SliderWindowController);
                if (_local_2)
                {
                    _local_3 = _local_2.getValue();
                    _local_4 = _local_3;
                    _roomEvents.localization.registerParameter("wiredfurni.params.usercountmin", "value", ("" + _local_4));
                };
            };
        }

        private function onMaxSliderChange(_arg_1:Event):void
        {
            var _local_2:SliderWindowController;
            var _local_4:Number;
            var _local_3:int;
            if (_arg_1.type == "change")
            {
                _local_2 = (_arg_1.target as SliderWindowController);
                if (_local_2)
                {
                    _local_4 = _local_2.getValue();
                    _local_3 = _local_4;
                    _roomEvents.localization.registerParameter("wiredfurni.params.usercountmax", "value", ("" + _local_3));
                };
            };
        }


    }
}

