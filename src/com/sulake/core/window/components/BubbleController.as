package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.PropertyStruct;

    public class BubbleController extends FrameController implements IBubbleWindow 
    {

        private static const TAG_POINTER_UP_ELEMENT:String = "_POINTER_UP";
        private static const TAG_POINTER_DOWN_ELEMENT:String = "_POINTER_DOWN";
        private static const TAG_POINTER_LEFT_ELEMENT:String = "_POINTER_LEFT";
        private static const TAG_POINTER_RIGHT_ELEMENT:String = "_POINTER_RIGHT";

        private var _direction:String = "down";
        private var _pointerOffset:int = 0;

        public function BubbleController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        public function get direction():String
        {
            return (_direction);
        }

        public function set direction(_arg_1:String):void
        {
            var _local_2:IWindow;
            if (_arg_1 != _direction)
            {
                _local_2 = getChildByName(_arg_1);
                if (!_local_2)
                {
                    throw (new Error((('Invalid pointer direction: "' + _arg_1) + '"!')));
                };
                getChildByName(_direction).visible = false;
                _local_2.visible = true;
                _direction = _arg_1;
                pointerOffset = _pointerOffset;
            };
        }

        public function get pointerOffset():int
        {
            return (_pointerOffset);
        }

        public function set pointerOffset(_arg_1:int):void
        {
            var _local_2:IWindow = getChildByName(_direction);
            if (!_local_2)
            {
                throw (new Error((('Invalid pointer direction: "' + _direction) + '"!')));
            };
            if (((_direction == "up") || (_direction == "down")))
            {
                _local_2.x = ((width / 2) + _arg_1);
            }
            else
            {
                _local_2.y = ((height / 2) + _arg_1);
            };
            _pointerOffset = _arg_1;
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            if (_pointerOffset != 0)
            {
                if (_arg_1 == this)
                {
                    if (_arg_2.type == "WE_RESIZED")
                    {
                        pointerOffset = _pointerOffset;
                    };
                };
            };
            return (_local_3);
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            _local_1.push(createProperty("direction", _direction));
            _local_1.push(createProperty("pointer_offset", _pointerOffset));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "direction":
                        direction = (_local_2.value as String);
                        break;
                    case "pointer_offset":
                        pointerOffset = (_local_2.value as int);
                };
            };
            super.properties = _arg_1;
        }


    }
}