package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.effects.EffectsWidget;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class EffectsWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1324:EffectsWidget;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                container = null;
                _SafeStr_1324 = null;
                _disposed = true;
            };
        }

        public function get type():String
        {
            return ("RWE_EFFECTS");
        }

        public function set widget(_arg_1:EffectsWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if (((_container) && (_container.inventory)))
            {
                _container.inventory.events.removeEventListener("HIEE_EFFECTS_CHANGED", onEffectsChanged);
            };
            _container = _arg_1;
            if (((_container) && (_container.inventory)))
            {
                _container.inventory.events.addEventListener("HIEE_EFFECTS_CHANGED", onEffectsChanged);
            };
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        private function onEffectsChanged(_arg_1:HabboInventoryEffectsEvent):void
        {
            if (_SafeStr_1324)
            {
                _SafeStr_1324.open();
            };
        }

        public function getWidgetMessages():Array
        {
            return (["RWRWM_EFFECTS"]);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (!_arg_1)
            {
                return (null);
            };
            switch (_arg_1.type)
            {
                case "RWRWM_EFFECTS":
                    _SafeStr_1324.open();
            };
            return (null);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function update():void
        {
        }


    }
}

