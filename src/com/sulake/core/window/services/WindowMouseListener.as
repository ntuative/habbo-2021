package com.sulake.core.window.services
{
    import flash.display.DisplayObject;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import flash.events.Event;

    public class WindowMouseListener extends WindowMouseOperator implements IMouseListenerService 
    {

        private var _eventTypes:Array = [];
        private var _areaLimit:uint = 0;

        public function WindowMouseListener(_arg_1:DisplayObject)
        {
            super(_arg_1);
        }

        public function get eventTypes():Array
        {
            return (_eventTypes);
        }

        public function get areaLimit():uint
        {
            return (_areaLimit);
        }

        public function set areaLimit(_arg_1:uint):void
        {
            _areaLimit = _arg_1;
        }

        override public function end(_arg_1:IWindow):IWindow
        {
            var _local_2:int;
            _local_2 = _eventTypes.length;
            while (_local_2 > 0)
            {
                _eventTypes.pop();
                _local_2--;
            };
            return (super.end(_arg_1));
        }

        override protected function handler(_arg_1:Event):void
        {
            var _local_2:Boolean;
            if (((_SafeStr_1162) && (!(_window.disposed))))
            {
                if (_eventTypes.indexOf(_arg_1.type) >= 0)
                {
                    if ((_arg_1 is WindowMouseEvent))
                    {
                        _local_2 = _window.hitTestGlobalPoint(new Point(WindowMouseEvent(_arg_1).stageX, WindowMouseEvent(_arg_1).stageY));
                        if (((_areaLimit == 1) && (!(_local_2))))
                        {
                            return;
                        };
                        if (((_areaLimit == 3) && (_local_2)))
                        {
                            return;
                        };
                    };
                    _window.update(null, WindowMouseEvent(_arg_1));
                };
            };
        }

        override public function operate(_arg_1:int, _arg_2:int):void
        {
        }


    }
}

