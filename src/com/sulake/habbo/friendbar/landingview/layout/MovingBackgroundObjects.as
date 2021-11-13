package com.sulake.habbo.friendbar.landingview.layout
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.utils.Map;
    import flash.events.EventDispatcher;
    import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects._SafeStr_225;
    import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.BackgroundObject;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.*;

    public class MovingBackgroundObjects implements IDisposable, IUpdateReceiver 
    {

        private static const MAX_OBJECTS:int = 20;

        private var _landingView:HabboLandingView;
        private var _SafeStr_743:Array = [];
        private var _SafeStr_2320:Map = new Map();
        private var _SafeStr_913:EventDispatcher = new EventDispatcher();
        private var _SafeStr_2321:String = "";

        public function MovingBackgroundObjects(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
            initializeObjectTypeMapping();
        }

        private function initializeObjectTypeMapping():void
        {
            _SafeStr_2320.add("line", _SafeStr_225.CLASS_LINEAR);
            _SafeStr_2320.add("spiral", _SafeStr_225.CLASS_SPIRAL);
            _SafeStr_2320.add("animated", _SafeStr_225.CLASS_STATIC_ANIMATED);
            _SafeStr_2320.add("randomwalk", _SafeStr_225.CLASS_RANDOM_WALK);
        }

        public function dispose():void
        {
            _landingView = null;
            for each (var _local_1:BackgroundObject in _SafeStr_743)
            {
                _local_1.dispose();
            };
            _SafeStr_743 = null;
            _SafeStr_2320.reset();
            _SafeStr_2320 = null;
            _SafeStr_913 = null;
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        public function initialize(_arg_1:IWindowContainer):void
        {
            var _local_4:int;
            var _local_2:String;
            var _local_3:BackgroundObject;
            _arg_1 = IWindowContainer(_arg_1.findChildByName("moving_objects_container"));
            if (_arg_1 == null)
            {
                return;
            };
            if (_SafeStr_743.length > 0)
            {
                return;
            };
            _local_4 = 1;
            while (_local_4 <= 20)
            {
                if (_SafeStr_2321 == "")
                {
                    _local_2 = _landingView.getProperty(("landing.view.bgobject." + _local_4));
                }
                else
                {
                    _local_2 = _landingView.getProperty(((("landing.view." + _SafeStr_2321) + ".bgobject.") + _local_4));
                };
                if (_local_2 != "")
                {
                    _local_3 = getObjectByDataContent(_local_4, _local_2, _arg_1);
                    if (_local_3 != null)
                    {
                        _SafeStr_743.push(_local_3);
                    };
                };
                _local_4++;
            };
        }

        public function update(_arg_1:uint):void
        {
            for each (var _local_2:BackgroundObject in _SafeStr_743)
            {
                _local_2.update(_arg_1);
            };
        }

        private function getObjectByDataContent(_arg_1:int, _arg_2:String, _arg_3:IWindowContainer):BackgroundObject
        {
            var _local_6:String;
            var _local_5:Class;
            var _local_4:Array = _arg_2.split(";");
            if (_local_4.length >= 2)
            {
                _local_6 = _local_4[1];
                _local_5 = _SafeStr_2320.getValue(_local_6);
                if (_local_5 != null)
                {
                    return (new _local_5(_arg_1, _arg_3, _SafeStr_913, _landingView, _arg_2));
                };
            };
            return (null);
        }

        public function set timingCode(_arg_1:String):void
        {
            _SafeStr_2321 = _arg_1;
        }


    }
}

