package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import flash.geom.Rectangle;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.events.WindowEvent;

    public class SubstituteParentController extends WindowController 
    {

        public function SubstituteParentController(_arg_1:WindowContext)
        {
            super("_CONTEXT_SUBSTITUTE_PARENT", 0, 0, 16, _arg_1, new Rectangle(0, 0, 2000, 2000), null, null, null, null, 0);
            _children = new Vector.<IWindow>();
            _SafeStr_899 = false;
        }

        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            return (null);
        }

        override public function setupGraphicsContext():IGraphicContext
        {
            return (null);
        }

        private function childParamUpdated(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.window;
            if (getChildIndex(_local_2) != -1)
            {
                if (!_local_2.testParamFlag(16))
                {
                    _local_2.desktop.addChild(_local_2);
                };
            };
        }

        override public function addChild(_arg_1:IWindow):IWindow
        {
            _children.push(_arg_1);
            return (_arg_1);
        }

        override public function addChildAt(_arg_1:IWindow, _arg_2:int):IWindow
        {
            var _local_3:WindowController = WindowController(_arg_1);
            if (_local_3.parent != null)
            {
                WindowController(_local_3.parent).removeChild(_local_3);
            };
            _children.splice(_arg_2, 0, _arg_1);
            _local_3.parent = this;
            return (_arg_1);
        }

        override public function getChildAt(_arg_1:int):IWindow
        {
            return ((_children) ? ((_arg_1 < _children.length) ? _children[_arg_1] : null) : null);
        }

        override public function getChildByID(_arg_1:int):IWindow
        {
            if (_children)
            {
                for each (var _local_2:IWindow in _children)
                {
                    if (_local_2.id == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        override public function getChildByName(_arg_1:String):IWindow
        {
            if (_children)
            {
                for each (var _local_2:IWindow in _children)
                {
                    if (_local_2.name == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        override public function findChildByName(_arg_1:String):IWindow
        {
            var _local_2:WindowController;
            if (_children)
            {
                for each (_local_2 in _children)
                {
                    if (_local_2.name == _arg_1)
                    {
                        return (_local_2);
                    };
                };
                for each (_local_2 in _children)
                {
                    _local_2 = (_local_2.findChildByName(_arg_1) as WindowController);
                    if (_local_2)
                    {
                        return (_local_2 as IWindow);
                    };
                };
            };
            return (null);
        }

        override public function removeChild(_arg_1:IWindow):IWindow
        {
            var _local_2:int = _children.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _children.splice(_local_2, 1);
                _arg_1.parent = null;
                return (_arg_1);
            };
            return (null);
        }

        override public function setChildIndex(_arg_1:IWindow, _arg_2:int):void
        {
            var _local_3:int = _children.indexOf(_arg_1);
            if (((_local_3 > -1) && (!(_arg_2 == _local_3))))
            {
                _children.splice(_local_3, 1);
                _children.splice(_arg_2, 0, _arg_1);
            };
        }

        override public function swapChildren(_arg_1:IWindow, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_6:int;
            var _local_5:IWindow = null;
            var _local_4:int;
            if ((((!(_arg_1 == null)) && (!(_arg_2 == null))) && (!(_arg_1 == _arg_2))))
            {
                _local_3 = _children.indexOf(_arg_1);
                if (_local_3 < 0)
                {
                    return;
                };
                _local_6 = _children.indexOf(_arg_2);
                if (_local_6 < 0)
                {
                    return;
                };
                if (_local_6 < _local_3)
                {
                    _local_5 = _arg_1;
                    _arg_1 = _arg_2;
                    _arg_2 = _local_5;
                    _local_4 = _local_3;
                    _local_3 = _local_6;
                    _local_6 = _local_4;
                };
                _children.splice(_local_6, 1);
                _children.splice(_local_3, 1);
                _children.splice(_local_3, 0, _arg_2);
                _children.splice(_local_6, 0, _arg_1);
            };
        }

        override public function swapChildrenAt(_arg_1:int, _arg_2:int):void
        {
            swapChildren(_children[_arg_1], _children[_arg_2]);
        }


    }
}

