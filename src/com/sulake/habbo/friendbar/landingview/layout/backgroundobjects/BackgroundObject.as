package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindow;
    import flash.events.EventDispatcher;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;

    public class BackgroundObject implements IDisposable, IUpdateReceiver 
    {

        private var _id:int;
        private var _window:IWindow;
        private var _events:EventDispatcher;
        private var _sprite:IStaticBitmapWrapperWindow;

        public function BackgroundObject(_arg_1:int, _arg_2:IWindowContainer, _arg_3:EventDispatcher, _arg_4:HabboLandingView, _arg_5:String, _arg_6:Boolean=false)
        {
            _id = _arg_1;
            _window = _arg_2;
            _events = _arg_3;
            if (_arg_6)
            {
                _sprite = IStaticBitmapWrapperWindow(_arg_4.getXmlWindow("moving_object"));
            }
            else
            {
                _sprite = IStaticBitmapWrapperWindow(_arg_4.getXmlWindow("moving_object_floating"));
            };
            _arg_2.addChild(_sprite);
        }

        public function dispose():void
        {
            _window = null;
            _sprite = null;
        }

        public function get disposed():Boolean
        {
            return (_window == null);
        }

        public function set sprite(_arg_1:IStaticBitmapWrapperWindow):void
        {
            _sprite = _arg_1;
        }

        public function get sprite():IStaticBitmapWrapperWindow
        {
            return (_sprite);
        }

        public function get window():IWindow
        {
            return (_window);
        }

        public function set window(_arg_1:IWindow):void
        {
            _window = _arg_1;
        }

        public function get events():EventDispatcher
        {
            return (_events);
        }

        public function get id():int
        {
            return (_id);
        }

        public function update(_arg_1:uint):void
        {
            if (!_sprite)
            {
                return;
            };
        }


    }
}