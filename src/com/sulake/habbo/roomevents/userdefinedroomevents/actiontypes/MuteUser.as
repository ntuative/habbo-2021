package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import flash.events.Event;

    public class MuteUser extends DefaultActionType 
    {

        private var _roomEvents:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;


        override public function get code():int
        {
            return (_SafeStr_226.MUTE_USER);
        }

        override public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return (getMessage(_arg_1).text);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(_slider.getValue());
            return (_local_2);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            getMessage(_arg_1).text = _arg_2.stringParam;
            var _local_3:int = _arg_2.intParams[0];
            _slider.setValue(_local_3);
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getMessage(_arg_1:IWindowContainer):ITextFieldWindow
        {
            return (ITextFieldWindow(_arg_1.findChildByName("chat_message")));
        }

        override public function validate(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):String
        {
            var _local_4:String;
            var _local_3:int = 100;
            if (getMessage(_arg_1).text.length > _local_3)
            {
                _local_4 = "wiredfurni.chatmsgtoolong";
                return (_arg_2.localization.getLocalization(_local_4, _local_4));
            };
            return (null);
        }

        override public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            _roomEvents = _arg_2;
            _slider = new SliderWindowController(_arg_2, getSlider(_arg_1), _arg_2.assets, 0, 10, 1);
            _slider.setValue(1);
            _slider.addEventListener("change", onSliderChange);
        }

        private function getSlider(_arg_1:IWindowContainer):IWindowContainer
        {
            return (_arg_1.findChildByName("slider_container") as IWindowContainer);
        }

        protected function onSliderChange(_arg_1:Event):void
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
                    _local_3 = int(_local_4).toString();
                    _roomEvents.localization.registerParameter("wiredfurni.params.length.minutes", "minutes", _local_3);
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

