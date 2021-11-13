package com.sulake.habbo.window.utils
{
    import flash.geom.ColorTransform;
    import flash.display.Stage;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.WindowController;
    import flash.geom.Matrix;
    import flash.events.Event;

    public class ModalDialog implements IModalDialog 
    {

        private static const MODAL_DIALOG_LAYER:int = 3;
        private static const COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.25, 0.25, 0.25);

        private static var _SafeStr_1161:Stage = null;
        private static var _windowManager:HabboWindowManagerComponent;
        private static var _container:IWindowContainer;
        private static var _SafeStr_4398:int;

        private var _disposed:Boolean;
        private var _rootWindow:IWindow;
        private var _background:IBitmapWrapperWindow;

        public function ModalDialog(_arg_1:HabboWindowManagerComponent, _arg_2:XML)
        {
            initialiseStaticMembers(_arg_1);
            _background = (modalContext.create("", "", 21, 0, 1, new Rectangle(0, 0, 1, 1), null, _container, 0) as IBitmapWrapperWindow);
            _rootWindow = _windowManager.buildFromXML(_arg_2, 3);
            _container.addChild(_rootWindow);
            _rootWindow.center();
            _container.visible = true;
            refresh();
        }

        private static function initialiseStaticMembers(_arg_1:HabboWindowManagerComponent):void
        {
            if (_SafeStr_1161 == null)
            {
                _windowManager = _arg_1;
                _SafeStr_1161 = _windowManager.context.displayObjectContainer.stage;
                _container = (modalContext.create("", "", 4, 0, 0, new Rectangle(0, 0, 1, 1), null, null, 0) as IWindowContainer);
                _SafeStr_1161.addEventListener("resize", onResize);
                _SafeStr_1161.addEventListener("enterFrame", onEnterFrame);
            };
        }

        private static function get modalContext():IWindowContext
        {
            return (_windowManager.getWindowContext(3));
        }

        private static function refresh():void
        {
            var _local_4:int;
            var _local_2:IDesktopWindow;
            var _local_9:IWindow;
            var _local_3:IWindowContext;
            var _local_6:IBitmapWrapperWindow;
            var _local_7:IWindow;
            if (_container == null)
            {
                return;
            };
            var _local_8:Boolean = (_container.numChildren == 0);
            _local_4 = 0;
            while (_local_4 < 3)
            {
                _local_2 = _windowManager.getWindowContext(_local_4).getDesktopWindow();
                _local_2.visible = _local_8;
                if (_local_8)
                {
                    for each (_local_9 in _local_2.iterator)
                    {
                        _local_9.invalidate();
                    };
                };
                _local_4++;
            };
            if (_local_8)
            {
                return;
            };
            var _local_5:Rectangle = new Rectangle(0, 0, Math.max(1, _SafeStr_1161.stageWidth), Math.max(1, _SafeStr_1161.stageHeight));
            _container.rectangle = _local_5;
            _local_4 = 0;
            while (_local_4 < _container.numChildren)
            {
                _local_9 = _container.getChildAt(_local_4);
                if ((_local_4 % 2) == 0)
                {
                    _local_9.rectangle = _local_5;
                    IBitmapWrapperWindow(_local_9).bitmap = null;
                }
                else
                {
                    _local_9.center();
                };
                _local_4++;
            };
            var _local_1:BitmapData = new BitmapData(_local_5.width, _local_5.height, false, 0);
            _local_4 = 0;
            while (_local_4 < 3)
            {
                _local_3 = _windowManager.getWindowContext(_local_4);
                if (_local_3 != null)
                {
                    try
                    {
                        _local_1.draw(IDisplayObjectWrapper(_local_3.getDesktopWindow()).getDisplayObject());
                    }
                    catch(e:SecurityError)
                    {
                        Logger.log(("[ModalDialog] security error while drawing modal dialog:" + e.message));
                    };
                };
                _local_4++;
            };
            _local_1.colorTransform(_local_1.rect, COLOR_TRANSFORM);
            _local_4 = 0;
            while (_local_4 < _container.numChildren)
            {
                _local_9 = _container.getChildAt(_local_4);
                if ((_local_4 % 2) == 0)
                {
                    _local_6 = (_local_9 as IBitmapWrapperWindow);
                    if (_local_4 >= 2)
                    {
                        _local_6.bitmap = _local_1.clone();
                        _local_1 = _local_6.bitmap;
                        _local_7 = _container.getChildAt((_local_4 - 1));
                        _local_1.draw(WindowController(_local_7).getGraphicContext(true), new Matrix(1, 0, 0, 1, _local_7.x, _local_7.y), COLOR_TRANSFORM);
                    }
                    else
                    {
                        _local_6.bitmap = _local_1;
                    };
                };
                _local_9.visible = (_local_4 >= (_container.numChildren - 2));
                _local_9.invalidate();
                _local_4++;
            };
        }

        private static function onResize(_arg_1:Event):void
        {
            if (((_container == null) || (_container.numChildren <= 0)))
            {
                return;
            };
            _SafeStr_4398 = 2;
            _container.getChildAt((_container.numChildren - 1)).center();
        }

        private static function onEnterFrame(_arg_1:Event):void
        {
            if (((_container == null) || (_container.numChildren <= 0)))
            {
                return;
            };
            if (_SafeStr_4398 > 0)
            {
                _SafeStr_4398--;
                if (_SafeStr_4398 == 0)
                {
                    refresh();
                };
            };
        }


        public function get rootWindow():IWindow
        {
            return (_rootWindow);
        }

        public function get background():IBitmapWrapperWindow
        {
            return (_background);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_background != null)
                {
                    _background.dispose();
                    _background = null;
                };
                if (_rootWindow != null)
                {
                    _rootWindow.dispose();
                    _rootWindow = null;
                };
                refresh();
                if (((!(_container == null)) && (_container.numChildren == 0)))
                {
                    _container.visible = false;
                };
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}

