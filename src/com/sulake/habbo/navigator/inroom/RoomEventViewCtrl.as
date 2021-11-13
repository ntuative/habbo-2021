package com.sulake.habbo.navigator.inroom
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.navigator.TextFieldManager;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.EditEventMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CancelEventMessageComposer;
    import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdErrorEvent;
    import com.sulake.core.window.IWindow;

    public class RoomEventViewCtrl implements IDisposable 
    {

        private var _navigator:IHabboTransitionalNavigator;
        private var _window:IFrameWindow;
        private var _SafeStr_2907:TextFieldManager;
        private var _SafeStr_2908:TextFieldManager;

        public function RoomEventViewCtrl(_arg_1:IHabboTransitionalNavigator)
        {
            _navigator = _arg_1;
        }

        public function dispose():void
        {
            _navigator = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_2907 = null;
            _SafeStr_2908 = null;
        }

        public function get disposed():Boolean
        {
            return (_navigator == null);
        }

        public function show():void
        {
            if (((!(_window == null)) && (_window.visible)))
            {
                _window.visible = false;
                return;
            };
            prepareWindow();
            clearErrors();
            var _local_1:RoomEventData = _navigator.data.roomEventData;
            if (_local_1 == null)
            {
                createEvent();
            }
            else
            {
                editEvent(_local_1);
            };
            _window.visible = true;
            _window.activate();
        }

        private function editEvent(_arg_1:RoomEventData):void
        {
            _window.caption = _navigator.getText("navigator.eventsettings.editcaption");
            _SafeStr_2907.setText(_arg_1.eventName);
            _SafeStr_2908.setText(_arg_1.eventDescription);
        }

        private function createEvent():void
        {
            _window.caption = _navigator.getText("navigator.createevent");
            _SafeStr_2908.goBackToInitialState();
            _SafeStr_2907.goBackToInitialState();
        }

        private function getInput(_arg_1:String):ITextFieldWindow
        {
            return (ITextFieldWindow(_window.findChildByName(_arg_1)));
        }

        private function onClose(_arg_1:WindowEvent):void
        {
            close();
        }

        private function save():void
        {
            var _local_1:int = _navigator.data.roomEventData.adId;
            var _local_3:String = _SafeStr_2907.getText();
            var _local_2:String = _SafeStr_2908.getText();
            if (!isMandatoryFieldsFilled())
            {
                return;
            };
            _navigator.send(new EditEventMessageComposer(_local_1, _local_3, _local_2));
        }

        private function onEndButtonClick(_arg_1:WindowEvent):void
        {
            _navigator.send(new CancelEventMessageComposer(_navigator.data.roomEventData.adId));
            close();
        }

        private function onCancelButtonClick(_arg_1:WindowEvent):void
        {
            close();
        }

        private function onUnfocus(_arg_1:WindowEvent):void
        {
            if (_navigator.data.roomEventData != null)
            {
                save();
            };
        }

        private function onRoomAdError(_arg_1:RoomAdErrorEvent):void
        {
            this.clearErrors();
            var _local_2:RoomAdErrorMessageParser = _arg_1.getParser();
            var _local_3:int = _local_2.errorCode;
            if (_local_3 == 0)
            {
                _SafeStr_2907.displayError(_navigator.getText("roomad.error.0.description"));
                _SafeStr_2907.setText(_local_2.filteredText);
            }
            else
            {
                if (_local_3 == 1)
                {
                    _SafeStr_2908.displayError(_navigator.getText("roomad.error.0.description"));
                    _SafeStr_2908.setText(_local_2.filteredText);
                };
            };
        }

        private function isMandatoryFieldsFilled():Boolean
        {
            this.clearErrors();
            if (!_SafeStr_2907.checkMandatory(_navigator.getText("navigator.eventsettings.nameerr")))
            {
                return (false);
            };
            return (true);
        }

        private function clearErrors():void
        {
            _SafeStr_2907.clearErrors();
            _SafeStr_2908.clearErrors();
        }

        private function prepareWindow():void
        {
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_navigator.getXmlWindow("iro_event_settings"));
            addMouseClickListener(_window.findChildByTag("close"), onClose);
            _SafeStr_2907 = new TextFieldManager(_navigator, getInput("event_name"), 25);
            _SafeStr_2908 = new TextFieldManager(_navigator, getInput("event_desc"), 100);
            _SafeStr_2907.input.addEventListener("WE_UNFOCUSED", onUnfocus);
            _SafeStr_2908.input.addEventListener("WE_UNFOCUSED", onUnfocus);
            _navigator.communication.addHabboConnectionMessageEvent(new RoomAdErrorEvent(onRoomAdError));
            _window.center();
        }

        private function addMouseClickListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null)
            {
                _arg_1.addEventListener("WME_CLICK", _arg_2);
            };
        }

        private function find(_arg_1:String):IWindow
        {
            var _local_2:IWindow = _window.findChildByName(_arg_1);
            if (_local_2 == null)
            {
                throw (new Error((("Window element with name: " + _arg_1) + " cannot be found!")));
            };
            return (_local_2);
        }

        private function prepareEventTypes():void
        {
            var _local_2:int;
            var _local_4:String;
            var _local_1:String;
            var _local_3:Array = [];
            var _local_5:int = 100;
            _local_2 = 1;
            while (_local_2 < _local_5)
            {
                _local_4 = ("roomevent_type_" + _local_2);
                _local_1 = _navigator.getText(_local_4);
                if (((_local_1 == null) || (_local_1 == _local_4))) break;
                _local_3.push(_local_1);
                _local_2++;
            };
        }

        public function close():void
        {
            if (_window != null)
            {
                _window.visible = false;
            };
        }


    }
}

